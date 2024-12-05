class User < ApplicationRecord
  belongs_to :role, class_name: 'Role', foreign_key: 'role_id'
  has_many :messages
  has_many :student_groups
  has_many :groups, through: :user_groups
  enum role: { student: 0, teacher: 1, admin: 2 }
end
