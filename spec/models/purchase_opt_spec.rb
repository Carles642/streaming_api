require 'rails_helper'

RSpec.describe PurchaseOpt, type: :model do
  subject { build(:product, :movie) }
  describe 'Validations' do
    it 'has a valid factory' do
      expect(subject).to be_valid
    end
 
    it 'is invalid without a quality' do
      subject.quality = nil
      expect(subject).to be_invalid
    end

    it 'is invalid if quality flag has an invalid value' do
      subject.quality = 3
      expect(subject).to be_invalid
    end

    it 'is invalid if quality flag has an invalid value' do
      subject.quality = -1
      expect(subject).to be_invalid
    end

    it 'is invalid without a price' do
      subject.price = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without a positive price' do
      subject.price = -22.50
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
    it 'belongs_to product' do #Belongs to movies or seasons.
      assoc = described_class.reflect_on_association(:product)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
