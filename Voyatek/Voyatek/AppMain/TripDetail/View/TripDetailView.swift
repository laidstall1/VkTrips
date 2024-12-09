//
//  TripDetailView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 09/12/2024.
//

import SwiftUI

struct TripDetailView: View {
   @ObservedObject var viewModel: TripDetailViewModel
   
   var body: some View {
      ScrollView(showsIndicators: false) {
         VStack(alignment: .leading, spacing: 24) {
            Image("trip.placeholder")
               .resizable()
               .frame(height: 235)
               .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 4) {
               HStack {
                  Image(systemName: "calendar")
                     .font(.caption)
                  
                  Text("\(viewModel.trip?.startDate ?? "") → \(viewModel.trip?.endDate ?? "")")
               }
               
               Text(viewModel.trip?.tripName ?? "")
                  .font(.callout)
                  .bold()
               
               Text("\(viewModel.trip?.destination ?? "") | \(viewModel.trip?.travelStyle ?? "")")
                  .font(.caption)
                  .foregroundStyle(Color.VkTheme.brandGray.opacity(0.8))
               
               Spacer(minLength: 16)
               
               HStack(spacing: 12) {
                  createButton(title: "Trip Collaboration", icon: Image("handshake"))
                  
                  createButton(title: "Share trip", icon: Image("handshake"))
                  
                  Button {
                     
                  } label: {
                     Image(systemName: "ellipsis")
                  }
                  .tint(Color.VkTheme.primaryTextColor)
               }
               
               Spacer(minLength: 24)
               
               VStack(spacing: 8) {
                  ActivityView(theme: .activity, title: "Activities", subtitle: "Build, personalize, and optimize your itineraries with our trip planner.", action: {})
                  
                  ActivityView(theme: .hotel, title: "Hotels", subtitle: "Build, personalize, and optimize your itineraries with our trip planner.", action: {})
                  
                  ActivityView(theme: .activity, title: "Flights", subtitle: "Build, personalize, and optimize your itineraries with our trip planner.", action: {})
               }
               
               Spacer(minLength: 24)
               
               VStack {
                  HStack {
                     VStack(alignment: .leading) {
                        Text("Trip itineraries")
                           .font(.callout)
                           .bold()
                        
                        Text("Your trip itineraries are placed here")
                           .font(.caption)
                           .foregroundStyle(Color.VkTheme.brandGray.opacity(0.8))
                     }

                     Spacer()
                  }
                  
                  TripItineraryView(theme: .flight)
                  TripItineraryView(theme: .hotel)
                  TripItineraryView(theme: .activity)
               }
            }
            .padding(.horizontal, 16)
         }
         .frame(maxWidth: .infinity)
      }
      .onAppear(perform: {
         viewModel.fetchTripById()
      })
   }
   
   fileprivate func createButton(title: String, icon: Image) -> some View {
      HStack {
         icon
            .font(.headline)
            .foregroundStyle(Color.VkTheme.brandBlue)
         
         Text(title)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(Color.VkTheme.brandBlue)
      }
      .padding(.vertical, 12)
      .padding(.horizontal, 16)
      .overlay {
         RoundedRectangle(cornerRadius: K.Dm.defaultCornerRadius)
            .stroke(Color.VkTheme.brandBlue, lineWidth: 1)
      }
   }
}

#Preview {
   TripDetailView(viewModel: TripDetailViewModel(tripId: "0"))
}
