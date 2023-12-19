require 'rails_helper'

RSpec.describe Api::V1::HealthController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'returns JSON data with health information' do
      get :index
      health_data = JSON.parse(response.body)

      expect(health_data).to have_key('api_version')
      expect(health_data).to have_key('enviroment')
      expect(health_data).to have_key('message')
      expect(health_data['message']).to eq("I'm ok")
    end
  end
end