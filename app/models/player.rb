class Player < ActiveRecord::Base
  belongs_to :user
  has_many :scores, dependent: :destroy
  has_many :matches, through: :scores
  
  validates :name, presence: true, uniqueness: true
  
  mount_uploader :avatar, AvatarUploader

  # will_paginate per page size limit
  self.per_page = 10

end
