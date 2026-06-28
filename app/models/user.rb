class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, length: { maximum: 320 }

  has_many :user_teams, dependent: :destroy
  has_many :teams, through: :user_teams
end
