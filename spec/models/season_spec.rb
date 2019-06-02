require 'rails_helper'

RSpec.describe Season, type: :model do
  subject { build(:season) }
  describe 'Validations' do
    it 'has a valid factory' do
      expect(subject).to be_valid
    end

    it 'is invalid without a title' do
      subject.title = nil
      expect(subject).to be_invalid
    end
  
    it 'is invalid without a plot' do
      subject.plot = nil
      expect(subject).to be_invalid
    end

    it 'can have a created_at field' do
      subject.save
      expect(subject.created_at).not_to be_nil
    end

    it 'can have an updated_at field' do
      subject.save
      expect(subject.updated_at).not_to be_nil
    end
  end

  describe 'Associations' do
    it 'has episodes' do
      assoc = described_class.reflect_on_association(:episodes)
      expect(assoc.macro).to eq :has_many
    end
  end

  describe 'Index all' do
    it 'returns all data' do
      seasons = create_list(:season, 2)
      episodes = [[],[]]
      
      3.times do |index|
        episodes[0][index] = create(:episode, season: seasons[0], number: index+1)
      end
      episodes[1][0] = create(:episode, season: seasons[1])
        
      resp = Season.index_all

      resp.each_with_index do |season, index|
        expect(season['id']).to eq(seasons[index].id)
        season['episodes'].each_with_index do |ep, index_ep|
          expect(ep['id']).to eq(episodes[index][index_ep].id)
        end
      end
    end

    it 'returns seasons in order' do
      s1 = create(:season)
      s2 = create(:season, created_at: DateTime.now - 2.days)

      resp = Season.index_all
      expect(resp.first['id']).to eq(s2.id)
    end

    it 'returns episodes in order' do
      s1 = create(:season)
      ep0 = create(:episode, number: 3, season: s1)
      ep1 = create(:episode, number: 2, season: s1)
      ep2 = create(:episode, number: 1, season: s1)

      resp = Season.index_all
      expect(resp.first['episodes'][0]['id']).to eq(ep2.id)
    end
  end
end
