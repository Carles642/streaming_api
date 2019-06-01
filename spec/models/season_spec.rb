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
end
