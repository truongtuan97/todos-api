require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth/login' do
    # create test user
    let!(:user) { create(:user) }
    # set header for authorization
    let(:headers) { valid_header.except('Authorization') }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end

    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
    }.to_json
    end

    # returns auth token when request is valid
    context 'When request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'return an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'when request is invlaid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }
      
      it 'return a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end

end
