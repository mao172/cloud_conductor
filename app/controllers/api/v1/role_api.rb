require 'validators/exists_id'
module API
  module V1
    class RoleAPI < API::V1::Base
      resource :roles do
        desc 'List roles'
        params do
          optional :project_id, type: Integer, desc: 'Project id'
          optional :account_id, type: Integer, desc: 'Account id'
        end
        get '/' do
          if params[:project_id]
            if params[:account_id]
              ::Role.assigned_to(params[:project_id], params[:account_id]).select do |role|
                can?(:read, role)
              end
            else
              ::Role.find_by_project_id(params[:project_id]).select do |role|
                can?(:read, role)
              end
            end
          else
            ::Role.all.select do |role|
              can?(:read, role)
            end
          end
        end

        desc 'Show role'
        params do
          requires :id, type: Integer, desc: 'Role id'
        end
        get '/:id' do
          role = ::Role.find(params[:id])
          authorize!(:read, role)
          role
        end

        desc 'Create role'
        params do
          requires :project_id, type: Integer, exists_id: :project, desc: 'Project id'
          requires :name, type: String, desc: 'Role name'
          optional :description, type: String, desc: 'Role description'
        end
        post '/' do
          project = ::Project.find_by(id: params[:project_id])

          authorize!(:read, project)
          authorize!(:create, ::Role, project: project)
          ::Role.create!(declared_params)
        end

        desc 'Update role'
        params do
          requires :id, type: Integer, desc: 'Role id'
          optional :name, type: String, desc: 'Role name'
          optional :description, type: String, desc: 'Role description'
        end
        put '/:id' do
          role = ::Role.find(params[:id])
          authorize!(:update, role)
          role.update_attributes!(declared_params)
          role
        end

        desc 'Destroy role'
        params do
          requires :id, type: Integer, desc: 'Role id'
        end
        delete '/:id' do
          role = ::Role.find(params[:id])
          authorize!(:destroy, role)
          role.destroy
          status 204
        end
      end
    end
  end
end
