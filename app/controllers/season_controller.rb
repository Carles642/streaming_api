class SeasonController < ApplicationController

  def index
    seasons = Season.all.order(:created_at).includes(:episodes).order('episodes.number').to_a
    result = []
    seasons.each_with_index do |season, index|
      result[index] = season.attributes
      result[index]['episodes'] = season.episodes
    end   
    return render json: result, status: :ok
  end

end
