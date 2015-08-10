class User < ActiveRecord::Base

  has_many :tournaments, dependent: :destroy
  has_many :players, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  validates :email, presence: true
  validates :email, uniqueness: true

  ROLES = %w[admin tournament_manager player_manager]

end
