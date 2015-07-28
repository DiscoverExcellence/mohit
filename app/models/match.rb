class Match < ActiveRecord::Base
  belongs_to :game
  belongs_to :tournament
  
  has_many :scores , dependent: :destroy
  has_many :players , through: :scores
  
  validates :no_of_players, presence: true, numericality: true

  def winner
    scores.order(score: :desc).take.player.name 
  end

  def looser
    scores.order(score: :asc).take.player.name
  end

end
