//
//  Location.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import Foundation

class Location: ObservableObject, Identifiable {
   let id = UUID()
   @Published var location: String
   @Published var city: String
   @Published var initials: String
   @Published var countryImageUrl: String
   
   init(location: String? = nil,
        city: String? = nil,
        initials: String? = nil,
        countryImageUrl: String? = nil) {
      self.location = location ?? ""
      self.city = city ?? ""
      self.initials = initials ?? ""
      self.countryImageUrl = countryImageUrl ?? ""
   }
   
   static let data: [Location] = [
      .init(location: "Laghouat Algeria ", city: "Laghouat", initials: "DZ", countryImageUrl: "nigeria.flag"),
      .init(location: "Doha, Qatar", city: "Doha, Qatar", initials: "QA", countryImageUrl: "nigeria.flag"),
      .init(location: "Lagos, Nigeria", city: "Laghouat", initials: "DZ", countryImageUrl: "nigeria.flag"),
      .init(location: "Laghouat Algeria ", city: "Muritala Muhammed", initials: "NG", countryImageUrl: "nigeria.flag")
   ]
}
