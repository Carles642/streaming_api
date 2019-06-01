class Movie < ApplicationRecord
  validates :title, :plot, presence: true
  has_many :purchase_opts, as: :product
end
