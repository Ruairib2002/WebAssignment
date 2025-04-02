class IssueVote < ApplicationRecord
  belongs_to :user
  belongs_to :issue
end
