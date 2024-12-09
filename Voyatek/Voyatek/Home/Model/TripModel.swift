//
//  TripModel.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import Foundation

class TripModel: Identifiable, ObservableObject {
   @Published var id: Int
   @Published var tripName: String
   @Published var travelStyle: String
   @Published var description: String
   @Published var startDate: String
   @Published var endDate: String
   @Published var destination: String
   @Published var noOfDays: String
   
   init(data: TripResponse) {
      self.id = data.id ?? 0
      self.tripName = data.tripName ?? ""
      self.travelStyle = data.travelStyle ?? ""
      self.description = data.description ?? ""
      self.startDate = data.startDate ?? ""
      self.endDate = data.endDate ?? ""
      self.destination = data.destination ?? ""
      self.noOfDays = String(DateFormatter.calculateDays(from: data.startDate, to: data.endDate) ?? 0)
   }
   
   init(id: Int? = nil, tripName: String? = nil, travelStyle: String? = nil, description: String? = nil, startDate: String? = nil, endDate: String? = nil, destination: String? = nil, noOfDays: String? = nil) {
      self.id = id ?? 0
      self.tripName = tripName ?? ""
      self.travelStyle = travelStyle ?? ""
      self.description = description ?? ""
      self.startDate = startDate ?? ""
      self.endDate = endDate ?? ""
      self.destination = destination ?? ""
      self.noOfDays = noOfDays ?? ""
   }
}
