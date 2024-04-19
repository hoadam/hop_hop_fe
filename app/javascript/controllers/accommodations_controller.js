import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  async connect() {
    
    const [{ Map }] = await Promise.all([google.maps.importLibrary("places")]);
    // Create the input HTML element, and append it.
    //@ts-ignore
    
    const placeAutocomplete = new google.maps.places.PlaceAutocompleteElement();

    //@ts-ignore
    document.getElementById("searchForm").appendChild(placeAutocomplete);
    placeAutocomplete.addEventListener("gmp-placeselect", (event) => this.afterGGSearch(event))
  }
  triggerGGSearch() {
    document.dispatchEvent(new Event("gmp-placeselect"))
  }
  async afterGGSearch(event) {
    let place = event.place
    await place.fetchFields({
      fields: ["displayName", "formattedAddress", "location"],
    });
    place = place.toJSON()
    
    // Update form
    this.updateAddress(place.formattedAddress)
    this.updateName(place.displayName) 
    // updateLatLon()
    this.updateLatLon(place.location.lat, place.location.lng)
  }
  updateAddress(address) {
    document.getElementById("accommodations_address").value = address
  }
  updateName(name) {
    document.getElementById("accommodations_name").value = name
  }
  updateLatLon(lat,lng) {
    document.getElementById("accommodations_lat").value = lat;
    document.getElementById("accommodations_lon").value = lng;
  }
  
}
