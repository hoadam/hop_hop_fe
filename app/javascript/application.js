// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "mapkick/bundle"

document.addEventListener('turbolinks:load', function() {
  let map;

  async function initMap() {
    const { Map } = await google.maps.importLibrary("maps");

    map = new Map(document.getElementById("map"), {
      center: { lat: -34.397, lng: 150.644 },
      zoom: 8,
    });

    // Access the data from the data-info attribute of your element
    const dataArray = document.getElementById("myElement").dataset.info;

    // Parse the data to extract the lat and lon
    const jsonData = JSON.parse(dataArray);

    jsonData.forEach(location => {
      const latitude = location.data.lat;
      const longitude = location.data.lon;

      const latLng = new google.maps.LatLng(latitude, longitude);

      placeMarker(latLng, map)
      map.panTo(latLng);
    });
  }

  function placeMarker(latLng, map) {
    new google.maps.marker.AdvancedMarkerElement({
      position: latLng,
      map: map,
    });
  }

  initMap();
});

    // Place markers for each set of coordinates in the array


  // Function to place a marker at a specific location on the map


  // map.addListener("click", (e) => {
  //   placeMarkerAndPanTo(e.latLng, map);
  // });



  // async function getPlaceDetails(Place) {
  //   const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
  //   // Use place ID to create a new Place instance.
  //   const place = new Place({
  //     id: Place.placeId
  //   });

  //   // Call fetchFields, passing the desired data fields.
  //   await place.fetchFields({
  //     fields: ["displayName", "formattedAddress", "location"],
  //   });
  //   // Log the result
  //   console.log(place.displayName);
  //   console.log(place.formattedAddress);

  //   // Add an Advanced Marker
  //   const marker = new AdvancedMarkerElement({
  //     map,
  //     position: place.location,
  //     title: place.displayName,
  //   });
  // }


