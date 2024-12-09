//
//  CreateTripViewModel.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import Foundation

enum TravelStyleEnum: String, CaseIterable {
   case solo = "Solo"
   case couple = "Couple"
   case family = "Family"
   case group = "Group"
}

class CreateTripViewModel: ObservableObject, InputFieldValidationProtocol {
   @Published var locationData: [Location] = []
   @Published var filteredLocationData: [Location] = []
   @Published var selectedLocation = Location() {
      didSet {
         trip.destination = selectedLocation.location
      }
   }
   
   @Published var trip: TripModel
   @Published var formIsValid = false
   
   init(trip: TripModel = TripModel()) {
      self.trip = trip
      VkHelpers.delay(durationInSec: 2) {
         self.locationData = Location.data
      }
   }
   
   func checkCreateTripFormStatus() -> Bool {
      return trip.tripName.isEmpty == false
      && trip.description.isEmpty == false
      && trip.travelStyle.isEmpty == false
   }
   
   func updateFormValidity() {
      formIsValid = checkCreateTripFormStatus()
   }
   
   fileprivate func filterLocation(_ searchText: String) {
     for location in locationData {
       let name = location.location
       if name.lowercased().contains(searchText.lowercased()) {
          filteredLocationData.append(location)
       }
     }
   }

   func beginSearch(for searchText: String) {
      filteredLocationData = []
      searchText.isEmpty ? filteredLocationData = filteredLocationData : filterLocation(searchText)
   }
}

