class Score < ActiveRecord::Base
  belongs_to :match
  belongs_to :player
  belongs_to :tournament

  scope :top_score, -> { order(score: :desc).take }
  scope :bottom_score, -> { order(score: :asc).take }

end
