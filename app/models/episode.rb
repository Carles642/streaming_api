class Episode < ApplicationRecord
  validates :number, :title, :plot, presence: true
  validates :number, numericality:{greater_than_or_equal_to: 1}
  validates :number, uniqueness:{scope: :season}

  belongs_to :season, touch: true
end
