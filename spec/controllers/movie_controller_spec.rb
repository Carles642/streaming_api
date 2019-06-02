require 'rails_helper'

RSpec.describe MovieController, type: :controller do
  describe 'index' do
    it 'returns correctly' do
      movies = create_list(:movie, 4)

      get :index

      expect(response.code).to eq('200')
    end
    
  end
end
