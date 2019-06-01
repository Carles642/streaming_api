class Season < ApplicationRecord
  validates :title, :plot, presence: true

  has_many :episodes, dependent: :destroy
end
