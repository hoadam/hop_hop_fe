// app/javascript/controllers/discover_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  async connect() {
    console.log("Discover Controller connected!")
    const [{ Map }] = await Promise.all([google.maps.importLibrary("places")]);
    // Create the input HTML element, and append it.
    //@ts-ignore

    const placeAutocomplete = new google.maps.places.PlaceAutocompleteElement();

    //@ts-ignore
    document.getElementById("searchForm").appendChild(placeAutocomplete);
    placeAutocomplete.addEventListener("gmp-placeselect", (event) => this.afterGGSearch(event))
  }
  triggerGGSearch() {
    console.log("Google Search triggered!")
    document.dispatchEvent(new Event("gmp-placeselect"))
  }
  async afterGGSearch(event) {
    console.log("Google Search done!")
    let place = event.place

    await place.fetchFields({
      fields: ["displayName", "formattedAddress", "location", "rating", "id"]
    })

    place = place.toJSON();
    // Update form

    console.log(place)
    this.updateDisplayName(place.displayName);
    this.updateAddress(place.formattedAddress);
    this.updateLatLon(place.location.lat, place.location.lng);
    this.updateRating(place.rating);
    this.updateId(place.id);
  }
  updateAddress(address) {
    document.getElementById("search_search").value = address;
  }
  updateLatLon(lat,lng) {
    document.getElementById("search_lat").value = lat;
    document.getElementById("search_lon").value = lng;
  }
  updateDisplayName(displayname) {
    document.getElementById("search_displayname").value = displayname;
  }
  updateRating(rating) {
    document.getElementById("search_rating").value = rating;
  }
  updateId(id) {
    document.getElementById("search_id").value = id;
  }
}
