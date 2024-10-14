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

  describe 'POST #create' do
    it 'creates a new event' do
      post :create, params: { event: { location: Faker::Address.city, start_time: 2.hours.from_now, end_time: 3.hours.from_now }, user_id: user_one.id }
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'raises an error for overlapping events' do
      create(:event, user: user_one, start_time: 2.hours.from_now, end_time: 4.hours.from_now)
      post :create, params: { event: { location: Faker::Address.city, start_time: 3.hours.from_now, end_time: 5.hours.from_now }, user_id: user_one.id }
      expect(response).to have_http_status(:bad_request)
    end
  end
end
