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
require './src/helpers/loader'

use Rack::Parser, content_types: {
  'application/json'  => proc { |body| JSON.parse(body) }
}

# Publish static files in public directory
use Rack::Static, urls: [/^\/$/, /.*\.html?/, '/.grunt', '/spec', '/js', '/css', '/locales', '/img'], root: 'public', index: 'index.html'

use ActiveRecord::ConnectionAdapters::ConnectionManagement

# Register route
map('/systems') { run SystemsController }
map('/clouds') { run CloudsController }
map('/patterns') { run PatternsController }