//
//  MyTripsView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import SwiftUI

struct MyTripsView: View {
   @Binding var tripData: [TripModel]
   @Binding var tripCategoryData: [String]
   @Binding var submissionText: String
   var action: ((Int) -> Void)?
   
   @State private var selectedTripId: String?

    var body: some View {
       VStack(alignment: .leading, spacing: 16) {
          VStack(alignment: .leading, spacing: 4) {
             Text("Your Trips")
                .font(.callout)
                .bold()
             
             Text("Your trip itineraries and  planned trips are placed here")
                .font(.caption)
                .foregroundStyle(Color.VkTheme.brandGray)
          }
          
          ZStack {
             RoundedRectangle(cornerRadius: 8)
                .fill(Color.VkTheme.brandGray.opacity(0.1))
                .frame(height: 65)
             
             VkMenuView(placeholder: "Choose trip category",
                        title: $submissionText,
                        options: tripCategoryData, hasBorder: false)
          }
          
          VStack {
             ForEach(tripData) { trip in
                NavigationLink(
                  destination: TripDetailView(viewModel: TripDetailViewModel(tripId: String(trip.id))),
                  tag: trip.id,
                  selection: $selectedTripId,
                  label: {
                     TripView(image: trip.base64ToImage(),
                              location: trip.destination,
                              title: trip.tripName,
                              date: trip.startDate,
                              noOfDays: "\(trip.noOfDays) day(s)", action: {
                        selectedTripId = trip.id
                     })
                  }
                )
                .buttonStyle(PlainButtonStyle())
             }
          }
       }
    }
}

#Preview {
   MyTripsView(tripData: .constant([]), tripCategoryData: .constant(["Planned Trips"]), submissionText: .constant(""), action: { _ in })
}
