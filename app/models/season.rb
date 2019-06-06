class Season < ApplicationRecord
  validates :title, :plot, presence: true

  has_many :episodes, dependent: :destroy
  has_many :purchase_opts, as: :product

  after_save :create_cache
  after_destroy :create_cache

  def self.index_all
    seasons= Rails.cache.fetch(self.cache_key) do
      seasons = Season.all.order(:created_at).includes(:episodes).order('episodes.number')
    end
    result = []
    seasons.each_with_index do |season, index|
      result[index] = season.attributes
      result[index]['episodes'] = season.episodes
    end  
 
    return result
    #return seasons.map_with_index{|season, index| &[index] = season.attributes; &[index]['episodes'] = season.episodes}
  end

  def self.cache_key
    'sea_' + Season.maximum('updated_at').to_s
  end
  private

  def create_cache
    Rails.cache.fetch(self.cache_key) do
      Season.all.order(:created_at).includes(:episodes).order('episodes.number')
    end
  end
  
end
