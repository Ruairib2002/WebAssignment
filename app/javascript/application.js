import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import GpsController from "./controllers/gps_controller";  // Import the GPS controller

// Initialize Stimulus application
const application = Application.start();

// Dynamically load all controllers from the controllers directory
const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

// Import controllers globally (after Stimulus setup)
import "controllers";  // Ensure all controllers are loaded

// Ensure initMap is declared globally for Google Maps callback
window.initMap = function () {
  const gpsController = new GpsController();
  gpsController.initMap();  // Initialize map using the GpsController
};

// Load Google Maps API script dynamically (with async loading)
const googleApiKey = "<%= ENV['GOOGLE_API_KEY'] %>";  // Replace with your actual API key
const script = document.createElement('script');
script.src = `https://maps.googleapis.com/maps/api/js?key=${googleApiKey}&libraries=places&callback=initMap`;
script.async = true;
script.defer = true;
document.head.appendChild(script);
