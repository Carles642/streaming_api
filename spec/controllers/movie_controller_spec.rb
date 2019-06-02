require 'rails_helper'

RSpec.describe MovieController, type: :controller do
  describe 'index' do
    it 'returns all movies' do
      movies = create_list(:movie, 4)
      
      get :index
      expect(response.code).to eq('200')

      expect(response.body).to eq(movies.to_json)
    end

    it 'returns movies in order' do
      create_list(:movie, 4)
      last = create(:movie, created_at: DateTime.now + 1.day)

      get :index
      parsed_resp = JSON.parse response.body

      expect(parsed_resp.last['id']).to eq(last.id)
    end
  end
end
