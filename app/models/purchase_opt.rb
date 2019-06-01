class PurchaseOpt < ApplicationRecord
  validates :quality, presence: true, numericality:{greater_than_or_equal_to: 0, less_than_or_equal_to: 1}
  validates :price, presence: true, numericality:{greater_than_or_equal_to: 0}

  belongs_to :product, polymorphic: true
end
