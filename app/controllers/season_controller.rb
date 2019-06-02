class SeasonController < ApplicationController

  def index
    return render json: Season.index_all, status: :ok
  end

end
