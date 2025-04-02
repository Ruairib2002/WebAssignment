class Issue < ApplicationRecord
  validates :latitude, presence: true
  validates :longitude, presence: true

  has_many :issue_votes
  has_many :users, through: :issue_votes

  def check_and_resolve!
    if self.issue_votes.where(resolved: true).count >= 5
      self.update(active: false)
      self.destroy
    end
  end
end
