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
require 'consul/client/kv'

module Consul
  module Client
    def self.connect(options = {})
      Consul::Client::Client.new options
    end

    class Client
      DEFAULT_OPTIONS = {
        port: 8500
      }

      def initialize(options = {})
        fail 'Consul::Client require host option' unless options[:host]
        @options = DEFAULT_OPTIONS.merge(options)
      end

      def kv
        Consul::Client::KV.new @options
      end

      def running?
        url = URI::HTTP.build(host: @options[:host], port: @options[:port], path: '/')
        @faraday = Faraday.new url

        response = @faraday.get('/')
        response.success?
      rescue
        false
      end
    end
  end
end