//
//  TripVIew.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import SwiftUI

struct TripView: View {
   @Binding var imageName: String
   let location: String
   let title: String
   let date: String
   let noOfDays: String
   @State var dominantColor: Color = .white
   var action: () -> Void
   
   init(imageName: Binding<String> = .constant("trip.placeholder"),
        location: String,
        title: String,
        date: String,
        noOfDays: String,
        action: @escaping () -> Void
   ) {
      self._imageName = imageName
      self.location = location
      self.title = title
      self.date = date
      self.noOfDays = noOfDays
      self.action = action
   }
   
   var body: some View {
      VStack(alignment: .center, spacing: 14) {
         ZStack(alignment: .topTrailing) {
            Image(imageName)
               .resizable()
               .scaledToFit()
               .onAppear(perform: {
                  extractDominantColor()
               })
            
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
      .border(Color.gray.opacity(0.3))
   }
   
   private func extractDominantColor() {
      guard let uiImage = UIImage(named: imageName) else { return }
      
      if let dominantColor = uiImage.dominantColor() {
         self.dominantColor = Color(dominantColor)
      }
   }
}

#Preview {
   TripView(location: "Paris",
            title: "Bahamas Family Trip",
            date: "19th April 2024",
            noOfDays: "5 Days", action: {})
}
