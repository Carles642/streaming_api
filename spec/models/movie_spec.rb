require 'rails_helper'

RSpec.describe Movie, type: :model do

  subject { create(:movie) }
  describe 'validations' do
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

    it 'has creation field' do
      expect(subject.created_at).not_to be_nil
    end

    it 'has updated field' do
      expect(subject.updated_at).not_to be_nil
    end
  
  end

end