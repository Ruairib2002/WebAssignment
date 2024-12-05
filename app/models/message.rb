class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many_attached :files

  validates :message_content, presence: true
end
