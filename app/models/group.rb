class Group < ApplicationRecord
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'

  has_many :student_groups
  has_many :students, through: :student_groups, source: :user

  has_many :user_groups
  has_many :users, through: :user_groups
  has_many_attached :files

  has_many :messages
  has_many :assignments

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
