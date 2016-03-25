describe API do
  include ApiSpecHelper
  include_context 'default_api_settings'

  describe 'TokenAPI' do

    describe 'GET /tokens' do

      it 'Get Authentication Token', autodoc: true do
        response = send(:post, '/api/v1/tokens', {email: admin_account.email, password: admin_account.password}, rack_env)

        expect(response.status).to be(201)
        expect(response.body).to match(admin_account.authentication_token)
      end

      it 'Incorrect Parameters: 400 Bad Request' do
        response = send(:post, '/api/v1/tokens', {}, rack_env)

        expect(response.status).to be(400)
      end

      it 'Authentication Failed: 401 Unauthorized' do
        response = send(:post, '/api/v1/tokens', {email: admin_account.email, password: 'no-password'}, rack_env)

        expect(response.status).to be(401)
      end
    end
  end
end
