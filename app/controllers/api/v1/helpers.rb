module API
  module V1
    module Helpers
      def require_no_authentication
        env['api.endpoint'].namespace == '/tokens'
      end

      def authenticate_account_from_token!
        conditions = params.slice(Devise::TokenAuthenticatable.token_authentication_key)
        account = Account.find_for_token_authentication(conditions)
        if account
          env['current_account'] = account
        else
          # Insert random sleep to make token prediction more difficult by timing attack.
          sleep((200 + rand(200)) / 1000.0)
          error!('Requires valid auth_token.', 401)
        end
      end

<<<<<<< a8a91b85f97b62226ec4762fa22ecccead8387b2
      def find_project(subject)
        project = nil
        unless subject.class == Class
          if subject.is_a?(Project)
            project = subject
          elsif !subject.is_a?(Account)
            project = subject.project
          end
        end
        project
      end

      def find_project_by_account(account, *args)
        account.projects.find do |project|
          project.id == args.pop[:project].id
        end if args.last[:project]
      end

      def create_ability(subject, *args)
        project = nil
        if args.last.is_a?(Hash) && args.last.key?(:project)
          if subject.class == Class
            project = args.pop[:project]
          elsif subject.is_a?(Account)
            project = find_project_by_account(subject, *args)
          else
            project = find_project(subject)
          end
        else
          project = find_project(subject)
        end
        Ability.new(current_account, project)
      end

      def track_api
=======
      def track_api(project_id)
>>>>>>> Move track_api from Base to each API
        account_id = current_account.id if current_account
        # project_id = current_project_id
        ::Audit.create!(ip: request.ip, account: account_id, status: status, request: request.url, project_id: project_id)
      end

<<<<<<< a8a91b85f97b62226ec4762fa22ecccead8387b2
      def authorize!(action, subject, *args)
        create_ability(subject, *args).authorize!(action, subject, *args)
      end

      def load_project_id
        if request.params.key?(:project_id)
          request.params[:project_id]
        elsif request.params.key?(:system_id)
          system = System.find(request.params[:system_id])
          system.project_id
        elsif request.params.key?(:cloud_id)
          cloud = Cloud.find(request.params[:cloud_id])
          cloud.project_id
        elsif request.params.key?(:blueprint_id)
          blueprint = Blueprint.find(request.params[:blueprint_id])
          blueprint.project_id
        elsif request.params.key?(:pattern_id)
          pattern = Pattern.find(request.params[:pattern_id])
          pattern.project_id
        elsif request.params.key?(:application_id)
          application = Application.find(request.params[:application_id])
          system = System.find(application.system_id)
          system.project_id
        end
      end

=======
>>>>>>> Move track_api from Base to each API
      def authorize!(*args)
        current_ability.authorize!(*args)
>>>>>>> Fix track_api
      end

      def can?(action, subject, *args)
        create_ability(subject, *args).can?(action, subject, *args)
      end

      def cannot?(action, subject, *args)
        create_ability(subject, *args).cannot?(action, subject, *args)
      end

      def current_ability
        ::Ability.new(current_account)
      end

      def current_account
        env['current_account']
      end

      def declared_params
        declared(params, include_missing: false).to_hash.with_indifferent_access
      end

      def permitted_params(*args)
        ActionController::Parameters.new(params.slice(*args)).permit(*args)
      end
    end
  end
end
