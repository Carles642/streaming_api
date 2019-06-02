require 'rails_helper'

RSpec.describe Movie, type: :model do

  subject { build(:movie) }
  describe 'Validations' do
    it 'has valid factory' do
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

    it 'can have a create_at field' do
      subject.save
      expect(subject.created_at).not_to be_nil
    end

    it 'can have an update_at field' do
      subject.save
      expect(subject.updated_at).not_to be_nil
    end
  
  end

  describe 'Index all' do
    it 'returns all movies' do
      movies = create_list(:movie, 4)
      
      expect(Movie.index_all).to eq(movies)
    end

    it 'returns movies in order' do
      create_list(:movie, 4)
      last = create(:movie, created_at: DateTime.now + 1.day)

      resp = Movie.index_all

      expect(resp.last['id']).to eq(last.id)
    end
  end

end