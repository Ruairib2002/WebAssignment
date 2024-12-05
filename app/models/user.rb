class User < ApplicationRecord
  # Associations
  belongs_to :role  # This assumes Role model exists and has a 'role_name' column
  has_many :messages
  has_many :student_groups
  has_many :groups, through: :student_groups
  has_many :user_groups
  has_many :groups, through: :user_groups

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Validations
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
end
