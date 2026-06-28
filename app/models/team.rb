class Team < ApplicationRecord
  validates :title, presence: true, length: { maximum: 128 }
  validates :description, presence: true, length: { maximum: 1024 }

  has_many :user_teams, dependent: :destroy
  has_many :users, through: :user_teams
  has_many :tasks, dependent: :destroy
end
