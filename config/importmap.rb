# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Include the Google Maps JavaScript API loader
pin "@googlemaps/js-api-loader", to: "google-maps-loader.js"
# import '@googlemaps/extended-component-library/place_overview.js'
