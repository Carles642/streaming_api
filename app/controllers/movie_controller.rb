class MovieController < ApplicationController

  def index
    movies = Movie.all.order(:created_at)
    return render json: movies, status: :ok
  end
end
