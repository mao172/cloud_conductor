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
  factory :system, class: System do
    sequence(:name) { |n| "system-#{n}" }
    domain 'example.com'
    template_parameters '{ "dummy": "value" }'

    before(:create) do |system|
      System.skip_callback :save, :before, :enable_monitoring
      System.skip_callback :save, :before, :update_dns

      system.add_cloud create(:cloud_aws), 1
      system.add_cloud create(:cloud_openstack), 2
    end

    after(:create) do
      System.set_callback :save, :before, :enable_monitoring, if: -> { monitoring_host_changed? }
      System.set_callback :save, :before, :update_dns, if: -> { ip_address }
    end
  end
end
