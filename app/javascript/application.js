// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "mapkick/bundle"

let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");

  console.log(document.getElementById("map"));

  map = new Map(document.getElementById("map"), {
    center: { lat: -34.397, lng: 150.644 },
    zoom: 8,
  });
  console.log(map);

  map.addListener("click", (e) => {
    console.log(e.latLng)
    placeMarkerAndPanTo(e.latLng, map);
  });
}

function placeMarkerAndPanTo(latLng, map) {
  new google.maps.Marker({
    position: latLng,
    map: map,
  });
  map.panTo(latLng);
}

initMap();
