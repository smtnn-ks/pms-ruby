class UserTeam < ApplicationRecord
  belongs_to :user
  belongs_to :team

  enum :role, { owner: 1, admin: 2, member: 3 }
end
