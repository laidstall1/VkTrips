//
//  TripModel.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import Foundation
import UIKit
import SwiftUI


class TripModel: Identifiable, ObservableObject {
   @Published var id: String
   @Published var tripName: String
   @Published var travelStyle: String
   @Published var description: String
   @Published var startDate: String
   @Published var endDate: String
   @Published var destination: String
   @Published var noOfDays: String
   @Published var imageUrl: String?
   
   init(data: TripResponse) {
      self.id = data.id ?? ""
      self.tripName = data.tripName ?? ""
      self.travelStyle = data.travelStyle ?? ""
      self.description = data.description ?? ""
      self.startDate = data.startDate ?? ""
      self.endDate = data.endDate ?? ""
      self.destination = data.destination ?? ""
      self.noOfDays = String(DateFormatter.calculateDays(from: data.startDate, to: data.endDate) ?? 0)
      self.imageUrl = data.imageUrl
   }
   
   init(id: String? = nil, tripName: String? = nil, travelStyle: String? = nil, description: String? = nil, startDate: String? = nil, endDate: String? = nil, destination: String? = nil, noOfDays: String? = nil) {
      self.id = id ?? ""
      self.tripName = tripName ?? ""
      self.travelStyle = travelStyle ?? ""
      self.description = description ?? ""
      self.startDate = startDate ?? ""
      self.endDate = endDate ?? ""
      self.destination = destination ?? ""
      self.noOfDays = noOfDays ?? ""
   }
   
   static var data: [TripModel] = [
//      .init(id: 0, tripName: "Bahamas Family Trip", travelStyle: "Solo", description: "A family reunion", startDate: "19th April 2024", endDate: "19th April 2024", destination: "Bahamas", noOfDays: "5"),
//      .init(id: 0, tripName: "Bahamas Family Trip", travelStyle: "Solo", description: "A family reunion", startDate: "19th April 2024", endDate: "19th April 2024", destination: "Bahamas", noOfDays: "5"),   .init(id: 0, tripName: "Bahamas Family Trip", travelStyle: "Solo", description: "A family reunion", startDate: "19th April 2024", endDate: "19th April 2024", destination: "Bahamas", noOfDays: "5"),
//      .init(id: 0, tripName: "Bahamas Family Trip", travelStyle: "Solo", description: "A family reunion", startDate: "19th April 2024", endDate: "19th April 2024", destination: "Bahamas", noOfDays: "5"),
   ]
   
   func base64ToUIImage() -> UIImage? {
      guard let base64String = imageUrl, let imageData = Data(base64Encoded: base64String) else {
         return nil
      }
      return UIImage(data: imageData)
   }
   
   func base64ToImage() -> Image? {
      guard let uiImage = base64ToUIImage() else {
         return nil
      }
      return Image(uiImage: uiImage)
   }
}
