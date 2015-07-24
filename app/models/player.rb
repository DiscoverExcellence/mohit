class Player < ActiveRecord::Base
  validates :name, presence: true 
  has_many :matches, through: :scores
end
