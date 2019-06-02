require 'rails_helper'

RSpec.describe Purchase, type: :model do
  require 'rails_helper'
  subject { build(:purchase, :season) }
  describe 'Validations' do
    it 'has a valid factory' do
      expect(subject).to be_valid
    end

    it 'generates a created_at field' do
      subject.save
      expect(subject.created_at).not_to be_nil
    end

    it 'generates a updated_at field' do
      subject.save
      expect(subject.updated_at).not_to be_nil
    end
  end

  describe 'Associations' do
    it 'belongs to user' do 
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'belongs to purchase_opt' do 
      assoc = described_class.reflect_on_association(:purchase_opt)
      expect(assoc.macro).to eq :belongs_to
    end
  end


end
