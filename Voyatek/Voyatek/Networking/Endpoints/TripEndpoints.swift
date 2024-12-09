//
//  Trips.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation

enum TripEndpoints: ApiInformation {
   case getTrips
   case getTrip(id: String)
   case createTrip(request: CreateTripRequest)
   case updateTrip
   
   var collectionName: String? {
      return "trips"
   }

   var method: HTTPMethod {
      switch self {
      case .getTrips, .getTrip:
            .get
         
      case .createTrip:
            .post
         
      case .updateTrip:
            .patch
      }
   }
   
   var path: String {
      if case .getTrip(let id) = self {
         return "/\(id)"
      }
      return ""
   }
   
   func getEncodedData() -> Encodable? {
      if case .createTrip(request: let req) = self {
         return req
      }
      return nil
   }
}
