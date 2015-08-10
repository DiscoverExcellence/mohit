class Tournament < ActiveRecord::Base
  
  belongs_to :game
  belongs_to :user
  has_many :matches, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :players, through: :scores, dependent: :destroy  
  
  validates :name, presence: true , uniqueness: true
  #tournament cannot exists without game
  validates :game_id, presence: true

  accepts_nested_attributes_for :matches

  self.per_page = 1

  ## Returns nil if no winner found
  def winner
    ##
    #  results format => {player_id1:score_sum1, player_id2:score_sum2, ...}
    results = scores.group("player_id").sum("score")
    return nil if results.empty?    

    max_score_sum = results.max_by { | player_id, score_sum | score_sum }
    player_id = max_score_sum[0]
    Player.find(player_id)

  end

  ## Returns nil if no top players found
  def top_players(number)
    raise TypeError,"#{number} is not Integer" unless number.is_a?(Integer)
    raise ArgumentError, "negative #{number} " if number < 0
    top_players = []
    ##
    #  results format => {player_id1:score_sum1, player_id2:score_sum2, ...}
    results = scores.group("player_id").sum("score")
    return nil if results.empty?

    # sort results in desc order by score_sum
    sorted_results = results.sort { | result1, result2 | result2[1] <=> 
                                    result1[1] } 
    top_results = sorted_results.first(number)
    top_results.each do | result |
      player_id = result[0]
      top_players << Player.find(player_id)
    end
    top_players
  end

end
