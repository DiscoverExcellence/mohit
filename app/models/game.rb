class Game < ActiveRecord::Base

  has_many :matches, dependent: :destroy
  has_many :tournaments, dependent: :destroy
  
  validates :name, presence: true, uniqueness: { case_sensitive: true }
  validates :scoring_points, presence: true, numericality: true

  # will_paginate per page limit
  self.per_page = 10
  
  # removed becoz we decided not to included nested_from_for game
  #accepts_nested_attributes_for :matches, :tournaments, allow_destroy: :true

end
