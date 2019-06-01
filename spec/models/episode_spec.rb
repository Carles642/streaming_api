require 'rails_helper'

RSpec.describe Episode, type: :model do
  subject { build(:episode) }
  describe 'Validations' do
    it 'has a valid factory' do
      expect(subject).to be_valid
    end
  
    it 'is invalid without a number' do
      subject.number = nil
      expect(subject).to be_invalid
    end

    it 'is invalid with number lower than 1' do
      subject.number = 0
      expect(subject).to be_invalid
    end

    it 'has a unique number within the same season' do
      subject.save
      ep = build(:episode, season_id: subject.season_id)
      expect(ep).to be_invalid
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
    it 'belongs_to season' do
      assoc = described_class.reflect_on_association(:season)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
