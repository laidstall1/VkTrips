//
//  SelectCityView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import SwiftUI

struct SelectCityView: View {
   @ObservedObject var viewModel: CreateTripViewModel
   @Binding var shouldDismiss: Bool
   @FocusState private var isFocused: Bool

    var body: some View {
       VStack(alignment: .leading) {
          Text("Please select a city")
             .font(.body)
             .foregroundStyle(Color.VkTheme.brandGray)
          
          VkTextField(placeholder: "Where to?",
                      submissionText: $viewModel.selectedLocation.location,
                      height: 78, cornerRadius: 2, validate: { value in
             viewModel.beginSearch(for: value)
          }, becomeResponder: _isFocused)
          .onAppear(perform: {
             isFocused = true
          })
          
          VStack(spacing: 20) {
             ForEach($viewModel.filteredLocationData) { location in
                LocationSearchView(model: location)
                   .onTapGesture {
                      viewModel.selectedLocation = location.wrappedValue
                      viewModel.filteredLocationData = []
                      shouldDismiss.toggle()
                   }
             }
          }
          
          Spacer()
       }
       .padding(.horizontal, 16)
       .padding(.vertical, 20)
    }
}

#Preview {
   SelectCityView(viewModel: CreateTripViewModel(trip: TripModel()), shouldDismiss: .constant(true))
}
