# -*- coding: utf-8 -*-
# Copyright 2014 TIS Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
require 'sinatra/activerecord'
require 'open-uri'

# rubocop:disable ClassLength
class Stack < ActiveRecord::Base
  belongs_to :system
  belongs_to :pattern
  belongs_to :cloud

  before_destroy :destroy_stack, unless: -> { pending? }
  before_save :create_stack, if: -> { ready? }

  scope :in_progress, -> { where(status: :PROGRESS) }
  scope :created, -> { where(status: :CREATE_COMPLETE) }

  validates :name, presence: true, uniqueness: { scope: :cloud_id }
  validates :system, presence: true
  validates :cloud, presence: true
  validates :pattern, presence: true

  validates_each :template_parameters, :parameters do |record, attr, value|
    begin
      JSON.parse(value) unless value.nil?
    rescue JSON::ParserError
      record.errors.add(attr, 'is malformed or invalid json string')
    end
  end

  validate do
    errors.add(:pattern, 'can\'t use pattern that contains uncompleted image') if pattern && pattern.status != :CREATE_COMPLETE
  end

  after_initialize do
    self.status ||= :PENDING
  end

  def create_stack
    common_parameters = JSON.parse(system.template_parameters, symbolize_names: true)
    stack_parameters = JSON.parse(template_parameters, symbolize_names: true)
    cloud.client.create_stack name, pattern, common_parameters.deep_merge(stack_parameters)
  rescue => e
    self.status = :ERROR
    Log.info("Create stack on #{cloud.name} ... FAILED")
    Log.error(e)
  else
    self.status = :PROGRESS
    Log.info("Create stack on #{cloud.name} ... SUCCESS")
  end

  def dup
    stack = super

    basename = name.sub(/-[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/, '')
    stack.name = "#{basename}-#{SecureRandom.uuid}"
    stack.status = :PENDING

    stack
  end

  def platform?
    pattern && pattern.type == :platform
  end

  def optional?
    pattern && pattern.type == :optional
  end

  %i(pending ready progress create_complete error).each do |method|
    define_method "#{method}?" do
      (attributes['status'] || :NIL).to_sym == method.upcase
    end
  end

  def status
    status = super
    return status && status.to_sym unless status && status.to_sym == :PROGRESS

    cloud.client.get_stack_status name if cloud.client
  rescue
    :ERROR
  end

  def outputs
    cloud.client.get_outputs name
  rescue
    {}
  end

  def destroy_stack
    cloud.client.destroy_stack name
  rescue => e
    Log.error "Some error occurred while destroy stack that is #{name} on #{cloud.name}."
    Log.error e
  end

  def payload
    payload = {}
    payload[pattern.name] = JSON.parse(pattern.to_json, symbolize_names: true)
    payload[pattern.name][:user_attributes] = JSON.parse(parameters, symbolize_names: true)

    payload
  end
end
