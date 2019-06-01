class Season < ApplicationRecord
  validates :title, :plot, presence: true

  has_many :episodes, dependent: :destroy
  has_many :purchase_opts, as: :product
end
