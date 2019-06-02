require 'rails_helper'

RSpec.describe SeasonController, type: :controller do
  describe 'index' do
    it 'returns correctly' do
      seasons = create_list(:season, 2)
      episodes = [[],[]]
      
      3.times do |index|
        episodes[0][index] = create(:episode, season: seasons[0], number: index+1)
      end
      
      get :index
      expect(response.code).to eq('200')
    end

  end
end
