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
FactoryGirl.define do
  factory :pattern do
    sequence(:name) { |n| "pattern_#{n}" }
    uri 'http://example.com/'

    after(:build) do
      Pattern.skip_callback :save, :before, :execute_packer
    end

    after(:create) do
      Pattern.set_callback :save, :before, :execute_packer
    end

    before(:create) do |pattern|
      pattern.clouds << create(:cloud_aws)
    end
  end
end