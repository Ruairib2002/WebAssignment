class Route < ApplicationRecord
  validates :from_lat, :from_lng, :to_lat, :to_lng, presence: true
  validates :name, presence: true
end
