class Match < ActiveRecord::Base
  has_many :scores, dependent: :destroy
  has_many :players, through: :scores
  
  belongs_to :game
  belongs_to :tournament
  
  validates :name, :venue, presence: true
 
  def winner
    scores.top_score.player
  end

  def losser
    scores.bottom_score.player
  end

end
