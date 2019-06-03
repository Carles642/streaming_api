class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, 
    format: /@.+\./
  
  has_many :purchases
  has_many :purchase_opts, through: :purchases

end
