//
//  TripItineraryView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 09/12/2024.
//

import SwiftUI

enum TripItineraryViewTheme: String {
   case activity = "Activities"
   case hotel = "Hotels"
   case flight = "Flights"
   
   var color: (Color, Color) {
      switch self {
      case .activity:
         return (Color.VkTheme.brandBlue, Color.white)
         
      case .hotel:
         return (Color.VkTheme.primaryTextColor, Color.white)
         
      case .flight:
         return (Color.VkTheme.brandLightBlue, Color.VkTheme.primaryTextColor)
      }
   }
   
   var iconImageName: String {
      switch self {
      case .activity:
         return "activity.icon"
      case .hotel:
         return "hotel.icon"
      case .flight:
         return "flight.icon"
      }
   }
   
   var placeholderImageName: String {
      switch self {
      case .activity:
         return "activity.placeholder"
      case .hotel:
         return "hotel.placeholder"
      case .flight:
         return "flight.placeholder"
      }
   }
}

struct TripItineraryView: View {
   let theme: TripItineraryViewTheme
   
    var body: some View {
       VStack {
          HStack {
             Image(theme.iconImageName)
             Text(theme.rawValue)
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(theme.color.1)
             
             Spacer()
          }
          .padding(.top, 18)
          .padding(.leading, 16)
          
          ZStack {
             RoundedRectangle(cornerRadius: K.Dm.defaultCornerRadius)
                .fill(Color.white)
                .frame(height: 358)
             VStack {
                Image(theme.placeholderImageName)
                
                Text("No request yet")
                   .fontWeight(.medium)
             }
          }
          .padding(.top, 16)
          .padding(.bottom, 16)
          .padding(.horizontal, 16)
       }
       .background(theme.color.0)
       .clipShape(.rect(cornerRadius: K.Dm.defaultCornerRadius))
    }
}

#Preview {
   TripItineraryView(theme: .flight)
}
