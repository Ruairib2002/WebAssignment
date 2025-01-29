import { Controller } from "@hotwired/stimulus";

// GPS controller class
export default class extends Controller {
  static targets = ["map", "lat", "lng"];

  // Color pairs for various markers
  businessColorPair = ["#0d6efd", "#0a58ca"];
  peopleColorPair = ["#198754", "#146c43"];
  colorPairs = [
    ["#d63384", "#a02d6b"],
    ["#fd7e14", "#c4620e"],
    ["#ffc107", "#cc9a06"],
    ["#6c757d", "#4d5156"],
    ["#0dcaf0", "#0a9ab5"],
    ["#f8f9fa", "#dee2e6"],
    ["#6c757d", "#495057"],
    ["#6f42c1", "#59359a"],
  ];
  numColors = this.colorPairs.length;

  // Stimulus values
  static values = {
    lat: Number,
    lng: Number,
    radius: Number,
    businesses: Array,
    people: Array,
    items: Array,
  };

  connect() {
    if (typeof google !== "undefined") {
      this.infoWindow = new google.maps.InfoWindow();
      this.initMap();
    }
  }

  // Main map initialization
  initMap() {
    this.createMap();
    if (this.hasRadiusValue) {
      this.createCircle();
    }
    this.createMarker();

    // Add markers for businesses, people, and items if provided
    if (this.hasBusinessesValue) {
      this.addMarkersForEntities(this.businessesValue, this.businessColorPair);
    }
    if (this.hasPeopleValue) {
      this.addMarkersForEntities(this.peopleValue, this.peopleColorPair);
    }
    if (this.hasItemsValue) {
      this.itemsValue.forEach((itemTypeData, index) => {
        this.addMarkersForEntities(itemTypeData[1], this.colorPairs[index % this.numColors]);
      });
    }

    // Add legend if necessary
    if (this.hasBusinessesValue || this.hasPeopleValue || this.hasItemsValue) {
      this.addLegend();
    }
  }

  // Create the map with initial coordinates
  createMap() {
    let lat = parseFloat(this.latTarget.value);
    let lng = parseFloat(this.lngTarget.value);

    // Use the provided values if the targets are empty
    if (isNaN(lat) || this.latTarget.value.trim() === "") {
      lat = this.latValue;
    }
    if (isNaN(lng) || this.lngTarget.value.trim() === "") {
      lng = this.lngValue;
    }

    const center = new google.maps.LatLng(lat, lng);
    const mapOptions = {
      center: center,
      zoom: this.hasRadiusValue ? this.calculateZoom(center.lat(), parseFloat(this.radiusValue)) : 14,
      mapId: "locations",
    };

    if (!this._map) {
      this._map = new google.maps.Map(this.mapTarget, mapOptions);
    }
    return this._map;
  }

  // Calculate zoom level based on distance (meters)
  calculateZoom(lat, meters) {
    const zoom = Math.log2((450 * 156543.03392 * Math.cos(lat * Math.PI / 180)) / meters);
    return Math.floor(zoom);
  }

  // Create a circle on the map
  createCircle() {
    if (!this._circle) {
      const map = this.createMap();
      const lat = parseFloat(this.latTarget.value);
      const lng = parseFloat(this.lngTarget.value);
      const radius = this.radiusValue;
      const center = { lat, lng };

      this._circle = new google.maps.Circle({
        map,
        strokeColor: "#FF0000",
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: "#FF0000",
        fillOpacity: 0.1,
        center,
        radius,
      });
    }
    return this._circle;
  }

  // Create a marker for the user's current location
  createMarker() {
    let lat = parseFloat(this.latTarget.value);
    let lng = parseFloat(this.lngTarget.value);

    if (isNaN(lat) || this.latTarget.value.trim() === "") {
      lat = this.latValue;
    }
    if (isNaN(lng) || this.lngTarget.value.trim() === "") {
      lng = this.lngValue;
    }

    const mapLocation = { lat, lng };

    const pin = new google.maps.marker.PinElement({
      scale: 0.85,
    });

    if (!this._marker) {
      this._marker = new google.maps.marker.AdvancedMarkerElement({
        map: this.createMap(),
        position: mapLocation,
        gmpDraggable: true,
        content: pin.element,
        zIndex: 100000,
      });
    }

    // Update the circle's position if the marker is dragged
    if (this.hasRadiusValue) {
      this._marker.addListener('drag', () => {
        const position = this._marker.position;
        this.createCircle().setCenter(position);
      });
    }

    // Update the lat and lng targets when the marker is dragged
    this._marker.addListener('dragend', () => {
      const position = this._marker.position;
      this.latTarget.value = parseFloat(position.lat).toFixed(5);
      this.lngTarget.value = parseFloat(position.lng).toFixed(5);
    });

    return this._marker;
  }

  // Add markers for businesses, people, or items
  addMarkersForEntities(entities, colorPair) {
    const map = this.createMap();
    const markers = entities.map((entity) => {
      let title = entity.item_type ? `${entity.item_type}<br/>` : "";
      title += `<a href="${entity.url}">${entity.name}</a><br/>`;
      const location = {
        lat: parseFloat(entity.lat),
        lng: parseFloat(entity.lng),
      };
      const marker = new google.maps.Marker({
        position: location,
        map: map,
        title: title,
        icon: {
          path: google.maps.SymbolPath.CIRCLE,
          scale: 7,
          fillColor: colorPair[0],
          fillOpacity: 0.6,
          strokeColor: colorPair[1],
          strokeWeight: 2,
        },
      });

      // Add event listener to show info window on click
      marker.addListener("click", () => {
        this.infoWindow.setContent(marker.title);
        this.infoWindow.open(map, marker);
      });
      return marker;
    });
    return markers;
  }

  // Add a legend to the map
  addLegend() {
    const legend = document.getElementById("legend");
    if (!legend) return;
    const map = this.createMap();
    const div = document.createElement("div");
    div.innerHTML = "<strong>Legend</strong>";
    legend.appendChild(div);

    // Add a color legend for each color pair
    this.colorPairs.forEach((colorPair, index) => {
      const div = document.createElement("div");
      div.innerHTML = `
        <div style="display: flex; align-items: center;">
          <span style="background-color: ${colorPair[0]}; width: 20px; height: 20px; margin-right: 5px;"></span>
          <span>${tt('.businesses')}</span>
        </div>`;
      legend.appendChild(div);
    });

    map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(legend);
  }
}
