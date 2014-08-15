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
module CloudConductor
  describe Client do
    describe '#new' do
      it 'returns initialized client with aws adapter' do
        cloud_aws = FactoryGirl.create(:cloud_aws)
        client = Client.new cloud_aws
        expect(client.type).to eq(:aws)
        expect(client.adapter.class).to eq(Adapters::AWSAdapter)
      end

      it 'returns initialized client with openstack adapter' do
        cloud_openstack = FactoryGirl.create(:cloud_openstack)
        client = Client.new cloud_openstack
        expect(client.type).to eq(:openstack)
        expect(client.adapter.class).to eq(Adapters::OpenStackAdapter)
      end
    end

    describe '#create_stack' do
      before do
        @name = 'stack_name'
        @pattern = FactoryGirl.create(:pattern)
        @parameters = { operating_system: { id: 1 } }

        @cloud = FactoryGirl.create(:cloud_aws)
        @client = Client.new @cloud

        path = File.expand_path("./tmp/patterns/#{SecureRandom.uuid}")
        @pattern.stub(:clone_repository).and_yield(path)
        @pattern.images << FactoryGirl.create(:image)

        @template_content = '{ "dummy": "dummy_value" }'
        @client.stub_chain(:open, :read).and_return(@template_content)

        Adapters::AWSAdapter.any_instance.stub(:create_stack)
      end

      it 'call adapter#create_stack with same arguments without pattern' do
        Adapters::AWSAdapter.any_instance.should_receive(:create_stack)
          .with(kind_of(String), anything, kind_of(Hash), kind_of(Hash))

        @client.create_stack @name, @pattern, @parameters
      end

      it 'will clone repository' do
        path = File.expand_path("./tmp/patterns/#{SecureRandom.uuid}")
        @pattern.should_receive(:clone_repository).and_yield(path)

        @client.create_stack @name, @pattern, @parameters
      end

      it 'will load template.json in repository' do
        path_pattern = %r{/tmp/patterns/[a-f0-9-]{36}/template\.json}

        @client.should_receive(:open).with(path_pattern) do
          double('file').tap do |stub|
            stub.should_receive(:read).and_return('{}')
          end
        end

        @client.create_stack @name, @pattern, @parameters
      end

      it 'will get images to suit conditions that has been registered in pattern' do
        @pattern.images.each do |image|
          image.cloud_id = @cloud.id
          image.operating_system_id = 1
        end

        @client.create_stack @name, @pattern, @parameters
        result = @parameters.select { |key, _| !key.to_s.match(/[a-z0-9_]*ImageId/).nil? }
        expect(result.size).to eq(1)
      end

      it 'add ImageId in parameter-hash only the number of images' do
        @pattern.images << FactoryGirl.create(:image)
        @pattern.images.each do |image|
          image.cloud_id = @cloud.id
          image.operating_system_id = 1
        end

        @client.create_stack @name, @pattern, @parameters
        result = @parameters.select { |key, _| !key.to_s.match(/[a-z0-9_]*ImageId/).nil? }
        expect(result.size).to eq(2)
      end

      it 'add Image data in parameter-hash' do
        @pattern.images.each do |image|
          image.cloud_id = @cloud.id
          image.operating_system_id = 1
        end

        @client.create_stack @name, @pattern, @parameters
        result = @parameters.select { |key, _| !key.to_s.match(/[a-z0-9_]*ImageId/).nil? }.values[0]
        expect(result[:Description]).to eq('')
        expect(result[:Type]).to eq('String')
        expect(result[:Default]).to eq(@pattern.images.first.image)
        expect(result[:ConstraintDescription]).to eq('')
      end

      it 'will call create_stack with content of template.json' do
        Adapters::AWSAdapter.any_instance.should_receive(:create_stack)
          .with(anything, @template_content, anything, anything)

        @client.create_stack @name, @pattern, @parameters
      end
    end

    describe '#get_stack_status' do
      it 'call adapter#get_stack_status with same arguments' do
        name = 'stack_name'

        Adapters::AWSAdapter.any_instance.should_receive(:get_stack_status)
          .with(kind_of(String), kind_of(Hash))

        client = Client.new FactoryGirl.create(:cloud_aws)
        client.get_stack_status name
      end
    end

    describe '#get_outputs' do
      it 'call adapter#get_outputs with same arguments' do
        name = 'stack_name'

        Adapters::AWSAdapter.any_instance.should_receive(:get_outputs)
          .with(kind_of(String), kind_of(Hash))

        client = Client.new FactoryGirl.create(:cloud_aws)
        client.get_outputs name
      end
    end

    describe '#destroy_stack' do
      it 'call adapter#destroy_stack with same arguments' do
        name = 'stack_name'

        Adapters::AWSAdapter.any_instance.should_receive(:destroy_stack)
          .with(kind_of(String), kind_of(Hash))

        client = Client.new FactoryGirl.create(:cloud_aws)
        client.destroy_stack name
      end
    end
  end
end