class LibraryController < ApplicationController

  def index_all
    result = {}
    result['movies'] = Movie.index_all
    result['seasons'] = Season.index_all

    return render json: result, status: :ok
  end
end
