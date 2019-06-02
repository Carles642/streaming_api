class Movie < ApplicationRecord
  validates :title, :plot, presence: true
  has_many :purchase_opts, as: :product

  def self.index_all
    return Movie.all.order(:created_at)
  end
end
