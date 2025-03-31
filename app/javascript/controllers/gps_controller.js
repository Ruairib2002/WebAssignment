import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["map", "issueType", "issueForm"];

  static values = {
    lat: Number,
    lng: Number,
    issueExpiryTime: Number,
  };

  connect() {
    if (typeof google !== "undefined") {
      this.directionsService = new google.maps.DirectionsService();
      this.directionsRenderer = new google.maps.DirectionsRenderer();
      this.initMap();

      // Fetch existing issues and add them as markers on the map
      fetch('/issues')
        .then(response => response.json())
        .then(issues => {
          issues.forEach(issue => {
            const issuePosition = new google.maps.LatLng(issue.latitude, issue.longitude);
            const marker = new google.maps.Marker({
              position: issuePosition,
              map: this._map,
              title: issue.category // Use the category as the title of the marker
            });

            // Add an InfoWindow to the marker to display more details when clicked
            const infoWindow = new google.maps.InfoWindow({
              content: `<div><strong>Category:</strong> ${issue.category}<br>
                        <strong>Coordinates:</strong> ${issue.latitude}, ${issue.longitude}</div>`
            });

            marker.addListener("click", () => {
              infoWindow.open(this._map, marker);
            });
          });
        });
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
      mapId: "locations", // Ensure this map ID is valid or remove if not needed
    };

    if (!this._map) {
      this._map = new google.maps.Map(this.mapTarget, mapOptions);
    }

    this.addClickListener();
    return this._map;
  }

  addClickListener() {
    this._map.addListener('click', (event) => {
      const position = event.latLng;
      this.placeMarker(position);
    });
  }

  placeMarker(position) {
    if (this.marker) {
      this.marker.setMap(null);
    }

    this.marker = new google.maps.Marker({
      position: position,
      map: this._map,
      draggable: true,
    });

    this.issueLatitude = position.lat();
    this.issueLongitude = position.lng();

    this.issueFormTarget.style.display = 'block';
    this.updateFormFields();

    if (this.issueExpiryTime) {
      setTimeout(() => {
        this.removeMarker();
      }, this.issueExpiryTime);
    }
  }

  updateFormFields() {
    this.issueFormTarget.querySelector("#latitude").value = this.issueLatitude;
    this.issueFormTarget.querySelector("#longitude").value = this.issueLongitude;
  }

  removeMarker() {
    if (this.marker) {
      this.marker.setMap(null);
      this.issueFormTarget.style.display = 'none'; // Hide the form when the marker is removed
    }
  }

  submitIssue(event) {
    event.preventDefault();
    const issueCategory = this.issueTypeTarget.value;
    const latitude = this.issueFormTarget.querySelector("#latitude").value;
    const longitude = this.issueFormTarget.querySelector("#longitude").value;

    const issueData = {
      issue: {
        category: issueCategory,
        latitude: latitude,
        longitude: longitude,
      }
    };

    const csrfToken = document.querySelector("meta[name='csrf-token']").content;

    fetch('/issues', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken, // Include CSRF token in the header
      },
      body: JSON.stringify(issueData)
    })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          this.addIssueMarker(data.issue);
          alert("Issue reported successfully!");
          this.removeMarker(); // Optional: you can keep the marker or remove it
        } else {
          alert("Failed to report the issue. Errors: " + data.errors.join(", "));
        }
      })
      .catch(() => alert("An error occurred. Please try again."));
  }

  // Function to add a new issue marker to the map
  addIssueMarker(issue) {
    const issuePosition = new google.maps.LatLng(issue.latitude, issue.longitude);

    const marker = new google.maps.Marker({
      position: issuePosition,
      map: this._map,
      title: issue.category,  // Set the title to the issue category for identification
    });

    const infoWindow = new google.maps.InfoWindow({
      content: `<div><strong>Category:</strong> ${issue.category}<br>
                <strong>Coordinates:</strong> ${issue.latitude}, ${issue.longitude}</div>`
    });

    marker.addListener("click", () => {
      infoWindow.open(this._map, marker);
    });
  }
}
