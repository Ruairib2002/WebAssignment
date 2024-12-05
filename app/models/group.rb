class Group < ApplicationRecord
  # Associations
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'

  has_many :student_groups
  has_many :students, through: :student_groups, source: :user

  has_many :user_groups
  has_many :users, through: :user_groups
  has_many_attached :files  # Enables file attachment with Active Storage

  has_many :messages
  has_many :files  # Optional, depending on how files are modeled

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
