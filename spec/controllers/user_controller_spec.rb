require 'rails_helper'

RSpec.describe UserController, type: :controller do
  before(:each) do
    @user = create(:user)
    request.headers['X-USER'] = @user.id
  end

  it 'rejects if user_id is invalid' do
    request.headers['X-USER'] = (@user.id - 2)
    post :purchase

    expect(response.code).to eq('401')
  end
  
  describe 'Purchase' do
    before(:each) do
      @movie = create(:movie)
      @pur_opt = create(:product, product: @movie)
    end

    it 'fails if opt_id is invalid' do
      post :purchase, params: {opt_id: (@pur_opt.id + 2)}

      expect(response.code).to eq('400')
    end

    it 'fails if the option is already bought' do
      create(:purchase, user: @user, purchase_opt: @pur_opt, created_at: (DateTime.now - 2.days))

      post :purchase, params: {opt_id: @pur_opt.id}

      expect(response.code).to eq('400')
    end

    it 'succeed if the option is already bought but expired' do
      create(:purchase, user: @user, purchase_opt: @pur_opt, created_at: (DateTime.now - 3.days))

      post :purchase, params: {opt_id: @pur_opt.id}

      expect(response.code).to eq('201')
    end

    it 'creates the option' do
      post :purchase, params: {opt_id: @pur_opt.id}

      expect(response.code).to eq('201')
    end
  end
  
end
