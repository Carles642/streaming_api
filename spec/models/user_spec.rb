require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }
  describe 'Validations' do
    it 'has a valid factory' do
      expect(subject).to be_valid
    end
 
    it 'is invalid without an email' do
      subject.email = nil
      expect(subject).to be_invalid
    end

    it 'is invalid with wrong formatted email' do
      subject.email = 'test.com'
    end

    it 'is invalid with wrong formatted email' do
      subject.email = 'test@test'
    end

    it 'is invalid without a created_at field' do
      subject.save
      expect(subject.created_at).not_to be_nil
    end

    it 'is invalid without an updated_at field' do
      subject.save
      expect(subject.updated_at).not_to be_nil
    end
  end

  describe 'Associations' do
    it 'has_many purchase_opts' do 
      assoc = described_class.reflect_on_association(:purchase_opts)
      expect(assoc.macro).to eq :has_many
    end

    it 'has_many purchases' do 
      assoc = described_class.reflect_on_association(:purchases)
      expect(assoc.macro).to eq :has_many
    end
  end
end
