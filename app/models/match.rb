class Match < ActiveRecord::Base
  has_many :scores, dependent: :destroy
  has_many :players, through: :scores
  
  belongs_to :game
  belongs_to :tournament

  validates :name, :venue, :played_on, presence: true
  #match cannot exist without game
  validates :game_id, presence: true

  # will_paginate per_page limit
  self.per_page = 10

  def winner
    begin
      scores.top_score.player
    # When Macth is created but no player assigned
    rescue NoMethodError
      nil
    end
  end

  def losser
    scores.bottom_score.player
  end

end
