class Issue < ApplicationRecord
  validates :latitude, :longitude, :description, :category, presence: true
end
