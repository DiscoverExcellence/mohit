class Player < ActiveRecord::Base
  validates :name, presence: true 
  has_many :scores, dependent: :destroy
  has_many :matches, through: :scores
end
