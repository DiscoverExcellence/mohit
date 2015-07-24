class Tournament < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: true }
  has_many :matches
  belongs_to :game
end
