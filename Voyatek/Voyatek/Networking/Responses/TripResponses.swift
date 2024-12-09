//
//  TripResponses.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation

struct TripResponse: Decodable {
   var id: Int?
   var tripName, travelStyle, description, startDate: String?
   var endDate, destination: String?
}
