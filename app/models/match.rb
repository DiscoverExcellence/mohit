class Match < ActiveRecord::Base
  has_many :scores, dependent: :destroy
  has_many :players, through: :scores
  
  belongs_to :game
  belongs_to :tournament
  
  validates :no_of_players, presence: true, numericality: true

  def winner
    scores.order(score: :desc).take.player 
  end

  def losser
    scores.order(score: :asc).take.player
  end

end
