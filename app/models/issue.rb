class Issue < ApplicationRecord
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :issue_type, presence: true
end
