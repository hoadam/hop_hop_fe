// app/javascript/controllers/discover_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Listen for the 'google-maps-callback' event
    // window.addEventListener('google-maps-callback', this.initMap.bind(this));
  }

//   initMap(event) {
//     console.log("Google Maps initialized");
//     // You can access the event detail if needed
//     const args = event.detail.args;
//     // Your map initialization code here
//   }
}
