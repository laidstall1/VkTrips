//
//  TripDataSource.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation

class TripDataSource {
   private let networkManager: NetworkManager<TripEndpoints>
   
   init(networkManager: NetworkManager<TripEndpoints> = NetworkManager(requestHandler: DefaultRequestHandler())) {
      self.networkManager = networkManager
   }
  
   func getTrips() async throws -> [TripResponse] {
      return try await networkManager.fetchRequest(type: [TripResponse].self, apiInformation: .getTrips)
   }
   
   func getTripById(id: String) async throws -> TripResponse {
      return try await networkManager.fetchRequest(type: TripResponse.self, apiInformation: .getTrip(id: id))
   }  
   
   func postCreateTrip(request: CreateTripRequest) async throws -> TripResponse {
      return try await networkManager.fetchRequest(type: TripResponse.self, apiInformation: .createTrip(request: request))
   }
}
