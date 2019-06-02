require 'rails_helper'

RSpec.describe SeasonController, type: :controller do
  describe 'index' do
    it 'returns all requested data' do
      seasons = create_list(:season, 2)
      episodes = [[],[]]
      
      3.times do |index|
        episodes[0][index] = create(:episode, season: seasons[0], number: index+1)
      end
      episodes[1][0] = create(:episode, season: seasons[1])
        
      get :index
      expect(response.code).to eq('200')

      p_resp = JSON.parse response.body

      p_resp.each_with_index do |season, index|
        expect(season['id']).to eq(seasons[index].id)
        season['episodes'].each_with_index do |ep, index_ep|
          expect(ep['id']).to eq(episodes[index][index_ep].id)
        end
      end
    end

    it 'returns seasons in order' do
      s1 = create(:season)
      s2 = create(:season, created_at: DateTime.now - 2.days)

      get :index
      p_resp = JSON.parse response.body
      expect(p_resp.first['id']).to eq(s2.id)
    end

    it 'returns episodes in order' do
      s1 = create(:season)
      ep0 = create(:episode, number: 3, season: s1)
      ep1 = create(:episode, number: 2, season: s1)
      ep2 = create(:episode, number: 1, season: s1)

      get :index
      p_resp = JSON.parse response.body
      expect(p_resp.first['episodes'][0]['id']).to eq(ep2.id)
    end
  end
end
