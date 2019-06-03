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

  describe 'List library' do
    before(:each) do
      @movies = create_list(:movie, 2)
      @seasons = create_list(:season_with_episodes, 3)

      mov_seasons = @movies + @seasons
      @p_opts = mov_seasons.map{|ms| create(:product, product: ms)}
      @pur = []
      @pur[0] = create(:purchase, user: @user, purchase_opt: @p_opts[0], created_at: (DateTime.now - 3.days))
      @pur[1] = create(:purchase, user: @user, purchase_opt: @p_opts[1], created_at: DateTime.now)
      @pur[2] = create(:purchase, user: @user, purchase_opt: @p_opts[2], created_at: (DateTime.now - 1.day))
      @pur[3] = create(:purchase, user: @user, purchase_opt: @p_opts[3], created_at: (DateTime.now - 2.days))
      @pur[4] = create(:purchase, user: @user, purchase_opt: @p_opts[4], created_at: DateTime.now)
    
      get :library
      @pr_resp = JSON.parse response.body
    end

    it 'not lists expired products' do
      expect(@pr_resp['movies']).not_to include(@pur[0].purchase_opt.product.attributes)
    end

    it 'lists active products' do
      expect(@pr_resp['movies']).to include(@pur[1].purchase_opt.product.attributes)
    end

    it 'orders the values from less to more time remaining' do
      expect(@pr_resp['seasons'][0]['id']).to eq(@pur[3].purchase_opt.product.id)
      expect(@pr_resp['seasons'][1]['id']).to eq(@pur[2].purchase_opt.product.id)
      expect(@pr_resp['seasons'][2]['id']).to eq(@pur[4].purchase_opt.product.id)
    end

    it 'retunrs ok' do
      expect(response.code).to eq('200')
    end

  end
end
