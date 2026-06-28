class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 128 }
  validates :description, presence: true, length: { maximum: 1024 }

  belongs_to :team
  belongs_to :author, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true
  has_many :comments, dependent: :destroy
  has_many :task_changelogs, dependent: :destroy
end
