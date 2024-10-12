require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  let(:user_one) { create(:user) }
  let!(:event) { create(:event, user: user_one) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, format: :json
      expect(response).to have_http_status(:ok)
    end

    it 'returns all events in JSON format' do
      get :index, format: :json
      parsed_body = JSON.parse(response.body)

      expect(parsed_body['events']['data'].first['attributes']['location']).to eq(event.location)
    end
  end
end
