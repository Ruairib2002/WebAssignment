# config/importmap.rb

# Pinning essential JS libraries (Turbo, Stimulus, and Google Maps API)
pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# Pin GPS controller to ensure it's loaded properly
pin "gps_controller", to: "controllers/gps_controller.js"

# Pin all controllers from the controllers directory
pin_all_from "app/javascript/controllers", under: "controllers"
