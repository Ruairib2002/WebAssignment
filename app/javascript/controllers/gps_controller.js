import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["map", "fromPlace", "toPlace"];

  static values = {
    lat: Number,
    lng: Number,
  };

  connect() {
    if (typeof google !== "undefined") {
      this.directionsService = new google.maps.DirectionsService();
      this.directionsRenderer = new google.maps.DirectionsRenderer();
      this.initMap();
    }
  }

  initMap() {
    this.createMap();
    this.directionsRenderer.setMap(this._map);
  }

  createMap() {
    const lat = this.latValue || 40.730610;
    const lng = this.lngValue || -73.935242;

    const center = new google.maps.LatLng(lat, lng);
    const mapOptions = {
      center: center,
      zoom: 14,
      mapId: "locations",
    };

    if (!this._map) {
      this._map = new google.maps.Map(this.mapTarget, mapOptions);
    }
    return this._map;
  }

  updateMapWithRoute() {
    const fromPlaceId = this.fromPlaceTarget.value;
    const toPlaceId = this.toPlaceTarget.value;

    if (fromPlaceId && toPlaceId) {
      Promise.all([
        fetch(`/places/${fromPlaceId}`).then(response => response.json()),
        fetch(`/places/${toPlaceId}`).then(response => response.json()),
      ])
        .then(([fromData, toData]) => {
          const fromPosition = { lat: fromData.latitude, lng: fromData.longitude };
          const toPosition = { lat: toData.latitude, lng: toData.longitude };

          const request = {
            origin: fromPosition,
            destination: toPosition,
            travelMode: google.maps.TravelMode.DRIVING,
            provideRouteAlternatives: true,
          };

          this.directionsService.route(request, (result, status) => {
            if (status === google.maps.DirectionsStatus.OK) {
              this.directionsRenderer.setDirections(result);
            } else {
              alert("Could not fetch routes. Please try again.");
            }
          });
        })
        .catch(() => alert("Error fetching place data. Please try again."));
    }
  }
}
