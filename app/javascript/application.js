// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// Find a way to re-render with the partial
/**
 * Functions -----------
 */

const waitForElement = async function(elem) {
  if (typeof  elem  ==  'string') {
      return  new Promise(function (resolve) {
          var  wfelem  =  function () {
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


async function addMO (selector) {
        // Select the node that will be observed for mutations
        const node = await waitForElement(selector)

        // Options for the observer (which mutations to observe)
        const config = { childList: true};
      
        // Callback function to execute when mutations are observed
        const callback = (mutationList, observer) => {
          for (const mutation of mutationList) {
            if (mutation.type === "childList") {
              console.log("A child node has been added or removed.", {mutationList});
              // where you would look for the map being initiated or not and re-init
            } else console.log(mutationList)
          }
        };
      
        // Create an observer instance linked to the callback function
        const observer = new MutationObserver(callback);
      
        // Start observing the target node for configured mutations
        observer.observe(node, config);
      
        // // Later, you can stop observing
        // observer.disconnect();
}



addMO("#map")

  let map 

  // document.querySelector("#map");
  // console.log("\n\n", {map})

  async function initMap() {
    const { Map } = await google.maps.importLibrary("maps");
    // map would be the return value of the pulling function looking for the map div
    // map = a function that keeps looking for the value, and then assigns it to map

    // map = await waitForElement("#map")
    





    map = new Map(await waitForElement("#map"), {
      center: { lat: -34.397, lng: 150.644 },
      zoom: 8,
    });
    
    console.log("\n\n",  {map})


    // Access the data from the data-info attribute of your element

    console.log(document.getElementById("searchResults"))
    const dataArray = document.getElementById("searchResults").dataset.info;
    console.log(dataArray);
    // Parse the data to extract the lat and lon
    const jsonData = JSON.parse(dataArray);

    console.log(jsonData);
    jsonData.forEach(location => {
      const latitude = location.data.lat;
      const longitude = location.data.lon;

      const latLng = new google.maps.LatLng(latitude, longitude);

      placeMarker(latLng, map)
      map.panTo(latLng);
    });
  }

  function placeMarker(latLng, map) {
    new google.maps.Marker({
      position: latLng,
      map: map,
    });
  }

  initMap();

  // Option 1: decouple and call init with a utility file
  // Option 2: Mutation observer, anytime something changes, initiate the map with the params


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

// Initialize and add the map
// let map;

// async function initMap() {
//   // The location of Uluru
//   const position = { lat: -25.344, lng: 131.031 };
//   // Request needed libraries.
//   //@ts-ignore
//   const { Map } = await google.maps.importLibrary("maps");
//   const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

//   // The map, centered at Uluru
//   map = new Map(document.getElementById("map"), {
//     zoom: 4,
//     center: position,
//     mapId: "DEMO_MAP_ID",
//   });

//   // The marker, positioned at Uluru
//   const marker = new AdvancedMarkerElement({
//     map: map,
//     position: position,
//     title: "Uluru",
//   });
// }

// initMap();
