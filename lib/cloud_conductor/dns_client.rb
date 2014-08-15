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
require 'open3'

module CloudConductor
  class DNSClient
    def update(domain, ip_address)
      dns_keyfile = CloudConductor::Config.cloudconductor.configuration[:dns_keyfile]
      dns_server = CloudConductor::Config.cloudconductor.configuration[:dns_server]
      ttl = CloudConductor::Config.cloudconductor.configuration[:dns_ttl]
      command = "server #{dns_server}\n" \
      "update delete #{domain}\n" \
      "send\n" \
      "update add #{domain} #{ttl} A #{ip_address}\n" \
      "send\n"
      Log.debug command
      nsupdate = "sudo /usr/bin/nsupdate -k #{dns_keyfile}"
      Log.debug nsupdate
      out, err, status = Open3.capture3(nsupdate, stdin_data: command)
      Log.debug "out = #{out}"
      Log.debug "err = #{err}"
      Log.debug "status = #{status}"
    end
  end
end