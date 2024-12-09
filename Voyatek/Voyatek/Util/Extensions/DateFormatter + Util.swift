//
//  DateFormatter + Util.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import Foundation

extension DateFormatter {
   static func calculateDays(from startDate: String?, to endDate: String?, dateFormat: String = "yyyy-MM-dd") -> Int? {
      guard let startDate = startDate, let endDate = endDate else {
         return nil
      }
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = dateFormat
      
      if let start = dateFormatter.date(from: startDate), let end = dateFormatter.date(from: endDate) {
         let calendar = Calendar.current
         let components = calendar.dateComponents([.day], from: start, to: end)
         return components.day
      }
      return nil
   }
   
   static func getDateString(from date: Date, format: String = "yyyy-MM-dd") -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      return dateFormatter.string(from: date)
   } 
   
   static func getMediumDateFromDateString(from dateStr: String, format: String = "yyyy-MM-dd") -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      if let date = dateFormatter.date(from: dateStr) {
         dateFormatter.dateStyle = .medium
         return dateFormatter.string(from: date)
      }
      return String()
   }
}
