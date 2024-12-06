class Message < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: 'User'
  has_many_attached :files

  validates :message_content, presence: true
end
