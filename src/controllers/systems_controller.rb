# Copyright 2014 TIS inc.
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
class SystemsController < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set(:clone) do |is_clone|
    condition do
      is_clone ? params[:system_id] : params[:system_id].nil?
    end
  end

  get '/' do
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 5).to_i

    state = {}
    state[:total_pages] = (System.count / per_page.to_f).ceil

    json [state, System.limit(per_page).offset((page - 1) * per_page)]
  end

  get '/:id' do
    json System.find(params[:id])
  end

  post '/', clone: false do
    system = System.new permit_params
    (params[:clouds] || []).each do |cloud|
      system.add_cloud Cloud.find(cloud[:id]), cloud[:priority]
    end

    unless system.save
      status 400
      return json system.errors
    end

    status 201
    json system
  end

  post '/', clone: true do
    begin
      previous_system = System.find(params[:system_id])
    rescue => e
      Log.error e
      status 400
      return json message: e.message
    end

    system = previous_system.dup
    unless system.save
      status 400
      return json system.errors
    end

    status 201
    json system
  end

  put '/:id' do
    begin
      system = System.find(params[:id])
    rescue => e
      Log.error e
      status 400
      return json message: e.message
    end

    system.update_attributes permit_paras
    unless system.save
      status 400
      return json system.errors
    end

    status 200
  end

  delete '/:id' do
    begin
      system = System.find(params[:id])
      system.destroy
    rescue => e
      Log.error e
      status 400
      return json message: e.message
    end
  end

  def permit_params
    ActionController::Parameters.new(params)
      .permit(:name, :pattern_id, :parameters, :monitoring_host, :domain)
  end
end