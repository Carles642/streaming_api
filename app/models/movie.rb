class Movie < ApplicationRecord
  validates :title, :plot, presence: true
  has_many :purchase_opts, as: :product

  after_save :create_cache
  after_destroy :create_cache

  def self.index_all
    return Rails.cache.fetch(self.cache_key) do
      Movie.all.order(:created_at)
    end
  end

  def self.cache_key
    'mov_' + Movie.maximum('updated_at').to_s
  end
  private

  def create_cache
    Rails.cache.fetch(self.cache_key) do
      Movie.index_all
    end
  end
end
