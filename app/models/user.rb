class User < ApplicationRecord
  belongs_to :role

  has_many :sent_messages, class_name: 'Message', foreign_key: 'user_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
  has_many :user_groups
  has_many :groups, through: :user_groups

  has_one_attached :profile_picture

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  after_initialize :set_default_role, if: :new_record?

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, length: { minimum: 6 }, allow_blank: true, on: :update

  private

  def set_default_role
    self.role ||= Role.find_by(role_name: 'student')
  end
end
