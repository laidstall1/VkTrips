//
//  CreateTripView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 09/12/2024.
//

import SwiftUI

protocol CreateTripViewDelegate: AnyObject {
   func getTrip(trip: TripModel)
}

struct CreateTripView: View {
   @ObservedObject var viewModel: CreateTripViewModel
   weak var delegate: CreateTripViewDelegate?
   @Binding var shouldDismiss: Bool

    var body: some View {
       ScrollView {
          VStack(alignment: .leading, spacing: 20) {
             VStack(alignment: .leading, spacing: 16) {
                Image("treepalm.icon")
                   .scaledToFit()
                   .frame(width: 44, height: 44)
                   .background(Color.VkTheme.brandLightBlue)
                   .clipShape(.rect(cornerRadius: K.Dm.defaultCornerRadius))
                
                VStack(alignment: .leading, spacing: 2) {
                   Text("Create a Trip")
                      .bold()
                   Text("Let's Go! Build Your Next Adventure")
                      .font(.caption)
                      .foregroundStyle(.brandGray)
                }
             }
             
             VStack(spacing: 16) {
                VkInputFieldView(label: "Trip Name", textField: VkTextField(placeholder: "Enter the trip name", submissionText: $viewModel.trip.tripName))
                   .onChange(of: viewModel.trip.tripName, perform: { value in
                      viewModel.updateFormValidity()
                   })
                
                VkInputFieldView(label: "Travel Style", textField: VkMenuView(placeholder: "Select your travel style", title: $viewModel.trip.travelStyle, options: TravelStyleEnum.allCases.map { $0.rawValue }))
                   .onChange(of: viewModel.trip.travelStyle, perform: { value in
                      viewModel.updateFormValidity()
                   })
                
                VkInputFieldView(label: "Trip Description", textField: VkTextEditorView(placeholder: "Tell us more about the trip", submissionText: $viewModel.trip.description))
                   .onChange(of: viewModel.trip.description, perform: { value in
                      viewModel.updateFormValidity()
                   })
             }
             
             Spacer(minLength: 40)
             
             VkPrimaryButton(action: {
                shouldDismiss.toggle()
                delegate?.getTrip(trip: viewModel.trip)

             }, title: "Next", isEnabled: $viewModel.formIsValid)
          }
          .padding(.horizontal, 16)
       }
       .frame(maxWidth: .infinity)
       .padding(.top, 20)
    }
}

#Preview {
   CreateTripView(viewModel: CreateTripViewModel(trip: TripModel()), shouldDismiss: .constant(false))
}
