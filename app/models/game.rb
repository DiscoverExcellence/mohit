class Game < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: true }
  validates :scoring_points, presence: true, numericality: true
  has_many :matches, dependent: :destroy
  has_many :tournaments, dependent: :destroy
  accepts_nested_attributes_for :matches
end
