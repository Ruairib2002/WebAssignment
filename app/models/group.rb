class Group < ApplicationRecord
  has_many :student_groups
  has_many :users, through: :student_groups
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :messages
  has_many :files
end
