// // Import and register all your controllers from the importmap under controllers/*

// import { application } from "controllers/application"

// import "discover_controller"

// // Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

// // Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// // import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// // lazyLoadControllersFrom("controllers", application)

// async function initMap() {
//   // Request needed libraries.
//   const { Map } = await google.maps.importLibrary("maps");
//   const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
//   const myLatlng = { lat: -25.363, lng: 131.044 };
//   const map = new google.maps.Map(document.getElementById("map"), {
//     zoom: 4,
//     center: myLatlng,
//     mapId: "DEMO_MAP_ID",
//   });
//   const marker = new google.maps.marker.AdvancedMarkerElement({
//     position: myLatlng,
//     map,
//     title: "Click to zoom",
//   });

//   map.addListener("center_changed", () => {
//     // 3 seconds after the center of the map has changed, pan back to the
//     // marker.
//     window.setTimeout(() => {
//       map.panTo(marker.position);
//     }, 3000);
//   });
//   marker.addListener("click", () => {
//     map.setZoom(8);
//     map.setCenter(marker.position);
//   });
// }

// initMap();

// // addEventListener("DOMContentLoaded")