// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"

// Declare the map variable)
let map

// Create an asynchronous function to initialize the map
async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

  // map would be the return value of the pulling function looking for the map div
  // map = a function that keeps looking for the value, and then assigns it to map
  map = new Map(await waitForElement("#map"), {
    center: { lat: 39.833333, lng: -98.585522 },
    zoom: 4,
  });
  map.addListener("click", (e) => {
    map.panTo(e.latLng);
  });
  // Adding a pin to search results
  // Access the data from the data-info attribute of your element
  const dataArray = document.getElementById("JSON").dataset.info;
  // Parse the data to extract the lat and lon
  const jsonData = JSON.parse(dataArray);
    const latitude = jsonData.lat
    const longitude = jsonData.lon

    const latLng = new google.maps.LatLng(latitude, longitude);
    const placeId = jsonData.id
  getPlaceDetails(placeId);
  console.log("test", getPlaceDetails(placeId))

  placeMarkerAndPanTo(latLng, map)

  searchLocation();
  // const latLng = new google.maps.LatLng(latitude, longitude);
  // console.log(latLng.slice(1))
  getPlaceDetails();
}

document.addEventListener('turbo:load', function() {
  console.log("Loading map!")
  initMap(); // Call your function to initialize Google Maps
  searchLocation();
  console.log("Searching!")
});

const getPlaceDetails = async function(placeId) {
  const { Place } = await google.maps.importLibrary("place");
  // Create a new Place instance using the place ID.
  const place = new Place({ id: placeId });
  
  // Retrieve the place details.
  const details = await place.fetchDetails()
  // Handle the retrieved place details.
  console.log(details); // Output the details to the console as an example
};

  const placeMarkerAndPanTo = function(latLng, map) {
    new google.maps.AdvancedMarker({
      position: latLng,
      map: map,
    });
    map.panTo(latLng);

    map.setZoom(15)
  }
  // Used to wait for the #map to appear, if it does, is it a String?
  // If it is a String, then return a promise
  const waitForElement = async function(elem) {
    console.log(elem)
    if (typeof  elem  ===  'string') {
      // Promise waits for the result of a function and will run as soon as it can?
        return  new Promise(function (resolve) {
          // declare a new function
            var  wfelem  =  function () {
              // query the document for css selector of #map
                if (null  !=  document.querySelector(elem)) {
                    resolve(document.querySelector(elem));
                } else {
                    window.requestAnimationFrame(wfelem);
                }
            };
            wfelem();
        });
    }
  };
