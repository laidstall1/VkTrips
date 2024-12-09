//
//  TripDetailViewModel.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 09/12/2024.
//

import Foundation


class TripDetailViewModel: ObservableObject {
   var dataSource: TripDataSource?
   
   @Published var trip: TripModel?
   
   var tripId: String?
   
   @Published var message = String()
   @Published var isLoading = false
   @Published var isFetched = false
   
   init(tripId: String) {
      self.tripId = tripId
      self.dataSource = TripDataSource()
   }
   
   func fetchTripById() {
      guard let id = tripId else { return }
      isLoading = true
      message = String()
      Task {
         do {
            guard let trip = try await dataSource?.getTripById(id: String(id)) else {
               DispatchQueue.main.async { [weak self] in
                  guard let self = self else { return }
                  updateState(isLoading: isLoading, isFetched: isFetched, message: "No trip found for ID \(id)")
               }
               return
            }
            let mappedTrip = TripModel(data: trip)
            DispatchQueue.main.async { [weak self] in
               guard let self = self else { return }
               self.trip = mappedTrip
               updateState(isLoading: isLoading, isFetched: isFetched, message: "")
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
   
   private func updateState(isLoading: Bool, isFetched: Bool, message: String?) {
       self.isLoading = isLoading
       self.isFetched = isFetched
       self.message = message ?? ""
   }
}
