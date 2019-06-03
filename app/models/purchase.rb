class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :purchase_opt

  def self.active
    two_days_ago = DateTime.now.beginning_of_day - 2.days
    where('created_at >= ?', two_days_ago)
  end
end
