class UserController < ApplicationController
  
  before_action :user_check
  def purchase
    opt_id = params['opt_id']

    return render json: {'message': 'option not exists'}, status: 400 if PurchaseOpt.where(id: opt_id).to_a.empty?

    purchased = Purchase.where(user_id: @current_user.id, purchase_opt_id: opt_id).active.first
    return render json: {'message': 'already purchased'}, status: 400 if purchased.present?

    pur = Purchase.new(user: @current_user, purchase_opt_id: opt_id)
    return render json: {'message': 'error while saving'}, status: 500 unless pur.save

    return render json: pur, status: 201
  end

  def library
    purchases = Purchase.all.active.includes(:purchase_opt).order(:created_at)
    result = {}
    result['movies'] = []
    result['seasons'] = []

    purchases.each do |pur|
      p_opt = pur.purchase_opt
      if p_opt.product_type == 'Movie'
        result['movies'] << p_opt.product
        next 
      end
      res = p_opt.product.attributes
      res['episodes'] = p_opt.product.episodes.order(:number)
      result['seasons'] << res
    end 
    #purchases.map{|p| p.purchase_opt.product}
    return render json: result, status: 200
  end
end