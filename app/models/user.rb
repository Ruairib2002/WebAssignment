class User < ApplicationRecord
  # Associations
  belongs_to :role, class_name: 'Role', foreign_key: 'role_id'
  has_many :messages
  has_many :student_groups
  has_many :groups, through: :student_groups
  has_many :user_groups
  has_many :groups, through: :user_groups

  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Callbacks
  after_initialize :set_default_role, if: :new_record?

  # Validations
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  private

  def set_default_role
    self.role ||= Role.find_by(role_name: 'student') # Default to 'student' role if none exists
  end
end
