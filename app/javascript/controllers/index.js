// // Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

import AccommodationsController from "./accommodations_controller"
import ActivitiesController from "./activities_controller"
import DiscoverContorller from "./discover_controller"
import TripDashboardController from "./trip_dashboard_controller"
import TripsController from "./trips_controller"

application.register("accommodations", AccommodationsController)
application.register("activities", ActivitiesController)
application.register("discover", DiscoverContorller)
application.register("trip-dashboard", TripDashboardController)
application.register("trips", TripsController)
