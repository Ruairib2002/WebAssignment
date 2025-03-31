class Place < ApplicationRecord
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  after_create :generate_routes

  private

  def generate_routes
    places = Place.where.not(id: self.id)

    places.each do |other_place|
      Route.find_or_create_by!(
        name: "#{self.name} to #{other_place.name}",
        from_lat: self.latitude,
        from_lng: self.longitude,
        to_lat: other_place.latitude,
        to_lng: other_place.longitude
      )

      Route.find_or_create_by!(
        name: "#{other_place.name} to #{self.name}",
        from_lat: other_place.latitude,
        from_lng: other_place.longitude,
        to_lat: self.latitude,
        to_lng: self.longitude
      )
    end
  end
end
