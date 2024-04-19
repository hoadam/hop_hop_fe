// let map;

// async function initMap() {
//   const { Map } = await google.maps.importLibrary("maps");

//   map = new Map(document.getElementById("map"), {
//     center: { lat: -34.397, lng: 150.644 },
//     zoom: 8,
//   });
// }

// initMap();

// async function initMap() {
//   // Request needed libraries.
//   const { Map } = await google.maps.importLibrary("maps");
//   const { AdvancedMarkerElement, PinElement } = await google.maps.importLibrary(
//     "marker",
//   );
//   const map = new google.maps.Map(document.getElementById("map"), {
//     zoom: 4,
//     center: { lat: -25.363882, lng: 131.044922 },
//     mapId: "DEMO_MAP_ID",
//   });

//   map.addListener("click", (e) => {
//     console.log("Click")
//     placeMarkerAndPanTo(e.latLng, map);
//   });
// }

// function placeMarkerAndPanTo(latLng, map) {
//   new google.maps.marker.AdvancedMarkerElement({
//     position: latLng,
//     map: map,
//   });
//   map.panTo(latLng);
// }

// initMap();
