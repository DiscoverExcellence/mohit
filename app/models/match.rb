class Match < ActiveRecord::Base

  validates :no_of_players, presence: true, numericality: true
  belongs_to :game
  has_many :players , through: :scores
end
