//
//  TripVIew.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import SwiftUI

struct TripView: View {
   var image: Image?
   let location: String
   let title: String
   let date: String
   let noOfDays: String
   @State var dominantColor: Color = .white
   var action: () -> Void
   
   init(image: Image? = nil,
        location: String,
        title: String,
        date: String,
        noOfDays: String,
        action: @escaping () -> Void
   ) {
      self.image = image
      self.location = location
      self.title = title
      self.date = date
      self.noOfDays = noOfDays
      self.action = action
   }
   
   var body: some View {
      VStack(alignment: .center, spacing: 14) {
         ZStack(alignment: .topTrailing) {
            if let image = image {
               image
                  .resizable()
                  .scaledToFit()
            } else {
               Image("trip.placeholder")
            }
            
            Text(location)
               .foregroundStyle(.white)
               .padding(.vertical, 10)
               .padding(.horizontal, 25)
               .background(
                  LinearGradient(
                     colors: [.gray, dominantColor.opacity(0.8)],
                     startPoint: .leading,
                     endPoint: .trailing
                  ).blur(radius: 0.5))
               .clipShape(.rect(cornerRadius: K.Dm.defaultCornerRadius))
               .padding(.trailing, 18)
               .padding(.top, 18)
         }
         .frame(maxWidth: .infinity)
         
         HStack {
            VStack(alignment: .leading, spacing: 8) {
               Text(title)
                  .font(.headline)
                  .bold()
                  .foregroundStyle(Color.VkTheme.primaryTextColor)
               
               HStack {
                  Text(date)
                     .font(.body)
                     .foregroundStyle(Color.VkTheme.primaryTextColor)
                  
                  Spacer()
                  
                  Text(noOfDays)
                     .font(.body)
                     .foregroundStyle(Color.VkTheme.brandGray)
               }
            }
            
            Spacer()
         }
         
         VkPrimaryButton(action: {
            action()

         }, title: "View")
         .frame(height: 48)
      }
      .padding(.all, 16)
      .clipShape(.rect(cornerRadius: 4))
      .overlay {
         RoundedRectangle(cornerRadius: 4)
            .stroke(Color.gray.opacity(0.3))
      }
   }
}

#Preview {
   TripView(location: "Paris",
            title: "Bahamas Family Trip",
            date: "19th April 2024",
            noOfDays: "5 Days", action: {})
}
