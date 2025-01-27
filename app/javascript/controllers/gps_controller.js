import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["map", "lat", "lng"]

  businessColorPair = ["#0d6efd", "#0a58ca"]
  peopleColorPair = ["#198754", "#146c43"]
  colorPairs = [
    ["#d63384", "#a02d6b"], // Dark / Darker Dark
    ["#fd7e14", "#c4620e"],  // Orange / Dark Orange
    ["#ffc107", "#cc9a06"], // Warning / Dark Warning
    ["#6c757d", "#4d5156"], // Secondary / Dark Secondary
    ["#0dcaf0", "#0a9ab5"], // Info / Dark Info
    ["#f8f9fa", "#dee2e6"], // Light / Dark Light
    ["#6c757d", "#495057"], // Muted / Dark Muted
    ["#6f42c1", "#59359a"], // Purple / Dark Purple
  ];
  numColors = this.colorPairs.length

  static values = {
    lat: Number,
    lng: Number,
    radius: Number,
    businesses: Array,
    people: Array,
    items: Array
  }

  connect() {
    if (typeof(google) != "undefined") {
      this.infoWindow = new google.maps.InfoWindow();
      this.initMap();
    }
  }

  initMap() {
    this.map();
    if (this.hasRadiusValue) {
      this.circle();
    }
    this.marker();

    if (this.hasBusinessesValue) {
      this.addMarkersForEntities(this.businessesValue, this.businessColorPair)
    }

    if (this.hasPeopleValue) {
      this.addMarkersForEntities(this.peopleValue, this.peopleColorPair)
    }

    if (this.hasItemsValue) {
      this.itemsValue.forEach((itemTypeData, index) => {
        this.addMarkersForEntities(itemTypeData[1], this.colorPairs[index % this.numColors])
      })
    }
    if (this.hasBusinessesValue || this.hasPeopleValue || this.hasItemsValue) {
      this.addLegend();
    }
  }

  map() {
    let lat = parseFloat(this.latTarget.value);
    let lng = parseFloat(this.lngTarget.value);

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
      mapId: "locations"
    }

    if (!this._map) {
      this._map = new google.maps.Map(this.mapTarget, mapOptions);
    }
    return this._map;
  }

  calculateZoom(lat, meters) {
    const zoom = Math.log2((450 * 156543.03392 * Math.cos(lat * Math.PI / 180)) / meters);
    return Math.floor(zoom);
  }

  circle() {
    if (!this._circle) {
      const map = this.map();
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
        radius
      });
    }
    return this._circle;
  }

  marker() {
    let lat = parseFloat(this.latTarget.value);
    let lng = parseFloat(this.lngTarget.value);

    if (isNaN(lat) || this.latTarget.value.trim() === "") {
      lat = this.latValue;
    }
    if (isNaN(lng) || this.lngTarget.value.trim() === "") {
      lng = this.lngValue;
    }

    let mapLocation = { lat, lng };

    const pin = new google.maps.marker.PinElement({
      scale: 0.85,
    });

    if (!this._marker) {
      this._marker = new google.maps.marker.AdvancedMarkerElement({
        map: this.map(),
        position: mapLocation,
        gmpDraggable: true,
        content: pin.element,
        zIndex: 100000
      });
    }

    if (this.hasRadiusValue) {
      this._marker.addListener('drag', () => {
        const position = this._marker.position;
        this.circle().setCenter(position);
      });
    }

    this._marker.addListener('dragend', () => {
      const position = this._marker.position;
      this.latTarget.value = parseFloat(position.lat).toFixed(5);
      this.lngTarget.value = parseFloat(position.lng).toFixed(5);
    });

    return this._marker;
  }

  addMarkersForEntities(entities, colorPair) {
    const map = this.map();
    const markers = entities.map((entity) => {
      let title = entity.item_type ? `${entity.item_type}<br/>` : "";
      title += `<a href="${entity.url}">${entity.name}</a>`;

      return new google.maps.marker.AdvancedMarkerElement({
        map: map,
        gmpClickable: true,
        title: title,
        position: { lat: parseFloat(entity.coords.lat), lng: parseFloat(entity.coords.lng) },
        content: new google.maps.marker.PinElement({
          scale: 0.75,
          glyph: "",
          background: colorPair[0],
          borderColor: colorPair[1]
        }).element
      });
    });

    markers.forEach((marker) => {
      marker.addListener("click", () => {
        this.infoWindow.close();
        this.infoWindow.setContent(marker.title);
        this.infoWindow.open(map, marker);
      });
    });
  }

  addLegend() {
    const legend = document.getElementById("legend");

    // Clear existing legend content
    legend.innerHTML = "";

    const legendItems = [
      { name: "Businesses", color: this.businessColorPair[0] },
      { name: "People", color: this.peopleColorPair[0] }
    ];

    this.itemsValue.forEach((itemTypeData, index) => {
      legendItems.push({ name: itemTypeData[0].substring(0, 20), color: this.colorPairs[index % this.numColors][0] });
    });

    legendItems.forEach(item => {
      const legendItem = document.createElement("div");
      legendItem.style.display = "flex";
      legendItem.style.alignItems = "center";
      legendItem.style.marginBottom = "5px";

      const colorBox = document.createElement("span");
      colorBox.style.backgroundColor = item.color;
      colorBox.style.width = "20px";
      colorBox.style.height = "20px";
      colorBox.style.display = "inline-block";
      colorBox.style.marginRight = "10px";

      const labelText = document.createElement("span");
      labelText.innerText = item.name;

      legendItem.appendChild(colorBox);
      legendItem.appendChild(labelText);
      legend.appendChild(legendItem);
    });

    this.map().controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(legend);
  }
}
