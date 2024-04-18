import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = {
        trip: Object
    }
      
    async connect() {
        const { Map } = await google.maps.importLibrary("maps");
        const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
        
        const map = new Map(document.getElementById("map"), {
            center: { lat: this.tripValue.lat, lng: this.tripValue.lon },
            zoom: 6,
            mapId: "8f470e658168b159"
        });
        
        const activities = Object.keys(this.tripValue.activities).flatMap( date => (
            this.tripValue.activities[date]
        ))
        
        activities.forEach(activity => {
            const marker = new AdvancedMarkerElement({
                map,
                position: { lat: activity.lat, lng: activity.lon },
              })
        })
       
    }

    
}