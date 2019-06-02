class MovieController < ApplicationController

  def index
    return render json: Movie.index_all, status: :ok
  end
end
