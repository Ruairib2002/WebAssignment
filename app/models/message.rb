class Message < ApplicationRecord
  belongs_to :user, foreign_key: 'posted_by'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id', optional: true

  validates :message_content, presence: true
end
