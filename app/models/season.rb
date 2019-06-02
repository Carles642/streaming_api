class Season < ApplicationRecord
  validates :title, :plot, presence: true

  has_many :episodes, dependent: :destroy
  has_many :purchase_opts, as: :product

  def self.index_all
    seasons = Season.all.order(:created_at).includes(:episodes).order('episodes.number').to_a

    result = []
    seasons.each_with_index do |season, index|
      result[index] = season.attributes
      result[index]['episodes'] = season.episodes
    end  
 
    return result
    #return seasons.map_with_index{|season, index| &[index] = season.attributes; &[index]['episodes'] = season.episodes}
  end

  
end
