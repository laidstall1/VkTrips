//
//  TripViewModel.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import Foundation

protocol InputFieldValidationProtocol {
   func checkCreateTripFormStatus() -> Bool
   func updateFormValidity()
}

enum TripHomeViewDateType {
   case startDate, endDate
}

class TripViewModel: ObservableObject {
   var dataSource: TripDataSource?
   
   var isFetched = false
   
   @Published var tripData: [TripModel]?
   @Published var message = String()
   @Published var isLoading = false
   @Published var tripCategoryData = ["Planned Trips", "Spontaneous Trips", "Yearly vacation", "Recurring trips"]
   @Published var selectedTripCategory = String()
   @Published var trip: TripModel
   
   @Published var formIsValid = false
   
   @Published var showSelectLocation = false
   @Published var showCreateTrip = false
   @Published var showDatePicker: TripHomeViewDateType?
   
   @Published var selectedStartDate = Date() {
      didSet {
         trip.startDate = DateFormatter.getDateString(from: selectedStartDate)
      }
   }
   @Published var selectedEndDate = Date() {
      didSet {
         trip.endDate = DateFormatter.getDateString(from: selectedEndDate)
      }
   }
   
   init() {
      self.dataSource = TripDataSource()
      trip = TripModel()
   }
   
   func fetchTrips() {
      isLoading = true
      message = String()
      Task {
         do {
            let trips = try await dataSource?.getTrips()
            let mappedTrips = trips?.map { TripModel(data: $0) }
            DispatchQueue.main.async {
               self.tripData = mappedTrips
               self.isLoading = false
               self.isFetched = true
            }
         }
         catch {
            DispatchQueue.main.async {
               if let error = (error as? ApiError)?.description {
                  self.message = error
               }
               self.isLoading = false
               self.isFetched = true
            }
         }
      }
   }
   
   func postCreateTrip() {
      let req = CreateTripRequest(id: trip.id,
                              tripName: trip.tripName,
                              travelStyle: trip.travelStyle,
                              description: trip.description,
                              startDate: trip.startDate,
                              endDate: trip.endDate,
                              destination: trip.destination)
      isLoading = true
      message = String()
      Task {
         do {
            let trip = try await dataSource?.postCreateTrip(request: req)
            DispatchQueue.main.async {
               self.isLoading = false
               self.message = "Successfully created \(trip?.tripName ?? "")"
            }
         }
         catch {
            DispatchQueue.main.async {
               if let error = (error as? ApiError)?.description {
                  self.message = error
               }
               self.isLoading = false
            }
         }
      }
   }
}

extension TripViewModel: InputFieldValidationProtocol {
   func checkCreateTripFormStatus() -> Bool {
      return trip.destination.isEmpty == false
      && trip.startDate.isEmpty == false
      && trip.endDate.isEmpty == false
   }
   
   func updateFormValidity() {
      formIsValid = checkCreateTripFormStatus()
   }
}

extension TripViewModel: CreateTripViewDelegate {
   func getTrip(trip: TripModel) {
      self.trip.tripName = trip.tripName
      self.trip.description = trip.description
      self.trip.travelStyle = trip.travelStyle
      postCreateTrip()
   }
}
