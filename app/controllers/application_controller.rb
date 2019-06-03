class ApplicationController < ActionController::API

  def user_check
    @current_user = User.where(id: request.headers['X-USER']).first
    return render json: {}, status: 401 if @current_user.nil?
  end
end
