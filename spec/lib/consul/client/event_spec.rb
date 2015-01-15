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
require 'consul/client/event'
module Consul
  class Client
    describe Event do
      before do
        @stubs  = Faraday::Adapter::Test::Stubs.new

        original_method = Faraday.method(:new)
        allow(Faraday).to receive(:new) do |*args, &block|
          original_method.call(*args) do |builder|
            builder.adapter :test, @stubs
            yield block if block
          end
        end

        @kv = double(:kv)
        allow(@kv).to receive(:merge)
        allow(@kv).to receive(:get)
        allow(Consul::Client::KV).to receive(:new).and_return(@kv)

        @faraday = Faraday.new('http://localhost/v1')
        @client = Consul::Client::Event.new @faraday, token: 'dummy_token'
      end

      describe '#fire' do
        it 'call kv#merge' do
          body = %({"ID":"12345678-1234-1234-1234-1234567890ab","Name":"configure","Payload":null,"NodeFilter":"","ServiceFilter":"","TagFilter":"","Version":1,"LTime":0})
          expect(@kv).to receive(:merge).with(Consul::Client::Event::PAYLOAD_KEY, {})

          @stubs.put('/v1/event/fire/configure') { [200, {}, body] }
          @client.fire(:configure, {})
        end

        it 'return nil if failed to request' do
          @stubs.put('/v1/event/fire/error') { [400, {}, ''] }
          expect(@client.fire(:error)).to be_nil
        end

        it 'return consul event ID' do
          body = %({"ID":"12345678-1234-1234-1234-1234567890ab","Name":"configure","Payload":null,"NodeFilter":"","ServiceFilter":"","TagFilter":"","Version":1,"LTime":0})
          @stubs.put('/v1/event/fire/configure') { [200, {}, body] }

          result = @client.fire(:configure)
          expect(result).to be_is_a String
          expect(result).to match(/^[a-f0-9\-]{36}$/)
        end

        it 'send PUT request with token' do
          @stubs.put('/v1/event/fire/dummy') do |env|
            expect(env.body).to eq('dummy_token')
          end
          @client.fire(:dummy)
        end
      end

      describe '#sync_fire' do
        before do
          @results = double(:results)
          allow(@results).to receive(:finished?).and_return(true)
          allow(@results).to receive(:success?).and_return(true)
          allow(@results).to receive(:hostnames).and_return(['dummy_host'])
          allow(@results).to receive(:[]).and_return(log: 'dummy_log')
          allow(@client).to receive(:fire).and_return(1)
          allow(@client).to receive(:get).and_return(@results)
        end

        it 'call fire' do
          expect(@client).to receive(:fire).with(:configure, {})

          @client.sync_fire(:configure, {})
        end

        it 'call get' do
          expect(@client).to receive(:get)

          @client.sync_fire(:configure, {})
        end

        it 'call finished?' do
          expect(@results).to receive(:finished?)
          @client.sync_fire(:configure, {})
        end

        it 'call success?' do
          expect(@results).to receive(:success?)

          @client.sync_fire(:configure, {})
        end

        it 'fail if finished? method has timed out' do
          allow(Timeout).to receive(:timeout).and_raise(Timeout::Error)

          expect { @client.sync_fire(:error) }.to raise_error
        end

        it 'fail if success? method returns false' do
          allow(@results).to receive(:success?).and_return(false)

          expect { @client.sync_fire(:error) }.to raise_error('{"dummy_host":"dummy_log"}')
        end
      end

      describe '#get' do
        it 'return nil if target event does not exist' do
          @stubs.get('/v1/kv/event/12345678-1234-1234-1234-1234567890ab?recurse=') { [404, {}, ''] }
          expect(@client.get('12345678-1234-1234-1234-1234567890ab')).to be_nil
        end

        it 'return EventResults that is created from responsed json' do
          value = {
            'event/12345678-1234-1234-1234-1234567890ab/host1' => {
              'event_id' => '4ee5d2a6-853a-21a9-7463-ef1866468b76',
              'type' => 'configure',
              'result' => '0',
              'start_datetime' => '2014-12-16T14:44:07+0900',
              'end_datetime' => '2014-12-16T14:44:09+0900',
              'log' => 'Dummy consul event log1'
            },
            'event/12345678-1234-1234-1234-1234567890ab/host2' => {
              'event_id' => '4ee5d2a6-853a-21a9-7463-ef1866468b76',
              'type' => 'configure',
              'result' => '0',
              'start_datetime' => '2014-12-16T14:44:07+0900',
              'end_datetime' => '2014-12-16T14:44:09+0900',
              'log' => 'Dummy consul event log2'
            }
          }

          allow(@kv).to receive(:get).and_return(value)

          expect(EventResults).to receive(:new).with(value).and_return(EventResults.new(value))
          expect(@client.get('12345678-1234-1234-1234-1234567890ab')).to be_is_a(EventResults)
        end
      end
    end
  end
end
