require 'rails_helper'

RSpec.describe LibraryController, type: :controller do

  describe 'Index all' do
    it 'returns movies and seasons' do
      seasons = create_list(:season, 2)
      episodes = [[],[]]
      
      3.times do |index|
        episodes[0][index] = create(:episode, season: seasons[0], number: index+1)
      end
      movies = create_list(:movie, 4)

      get :index_all

      expect(response.code).to eq('200')

      p_resp = JSON.parse response.body

      expect(p_resp['movies'].size).to eq(movies.size)
      expect(p_resp['seasons'].size).to eq(seasons.size)

    end
  end

end
