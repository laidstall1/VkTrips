//
//  ActivityView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 09/12/2024.
//

import SwiftUI

enum ActivityViewTheme: String {
   case activity = "Activities"
   case hotel = "Hotels"
   case flight = "Flights"
   
   var color: (Color, Color) {
      switch self {
      case .activity:
         return (Color.VkTheme.primaryTextColor, Color.white)
         
      case .hotel:
         return (Color.VkTheme.brandLightBlue, Color.VkTheme.primaryTextColor)
         
      case .flight:
         return (Color.VkTheme.primaryTextColor, Color.white)
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

struct ActivityView: View {
   let theme: ActivityViewTheme
   let title: String
   let subtitle: String
   var action: () -> Void
   
   var body: some View {
      VStack(alignment: .leading, spacing: 37) {
         VStack(alignment: .leading, spacing: 8) {
            Text(title)
               .bold()
               .foregroundStyle(theme.color.1)
            
            Text(subtitle)
               .foregroundStyle(theme.color.1)
               .lineSpacing(8)
         }
         
         VkPrimaryButton(action: action,
                         title: "Add \(title)")
      }
      .padding(.vertical, 16)
      .padding(.horizontal, 16)
      .background(theme.color.0)
      .frame(maxWidth: .infinity)
      .clipShape(.rect(cornerRadius: K.Dm.defaultCornerRadius))
    }
}

#Preview {
   ActivityView(theme: .activity, title: "Activities", subtitle: "Build, personalize, and optimize your itineraries with our trip planner.", action: {})
}
