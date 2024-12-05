class Message < ApplicationRecord
  belongs_to :user, foreign_key: 'posted_by'
  belongs_to :group
end
