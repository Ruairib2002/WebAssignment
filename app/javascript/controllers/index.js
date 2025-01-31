import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

window.initMap = function () {
  const gpsController = new application.getControllerForElementAndIdentifier(document.body, "gps");
  gpsController.initMap();
};

const googleApiKey = "<%= ENV['GOOGLE_API_KEY'] %>";
const script = document.createElement('script');
script.src = `https://maps.googleapis.com/maps/api/js?key=${googleApiKey}&libraries=places&callback=initMap`;
script.async = true;
script.defer = true;
document.head.appendChild(script);
