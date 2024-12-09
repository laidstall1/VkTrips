//
//  CreateTripRequest.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation

struct CreateTripRequest: Encodable {
   var id: String?
   var tripName, travelStyle, description, startDate: String?
   var endDate, destination, imageUrl: String?
}
