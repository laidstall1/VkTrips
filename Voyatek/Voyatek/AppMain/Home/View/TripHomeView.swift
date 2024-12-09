//
//  TripView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import SwiftUI

struct TripHomeView: View {
   @ObservedObject var viewModel: TripViewModel
   @ObservedObject var createTripVm: CreateTripViewModel
   
   init(viewModel: TripViewModel,
        createTripVm: CreateTripViewModel = CreateTripViewModel()
   ) {
      self.viewModel = viewModel
      self.createTripVm = createTripVm
   }
   
   var body: some View {
      ScrollView(showsIndicators: false) {
         VStack(spacing: 24) {
            ZStack(alignment: .bottom) {
               Rectangle()
                  .fill(Color.blue.opacity(0.25))
                  .frame(height: UIScreen.main.bounds.height * 0.65)
                  .frame(maxWidth: .infinity)
               
               VStack(spacing: 0) {
                  HStack(alignment: .top) {
                     Image("bg.left")
                     Image("bg.right")
                  }
                  Image("bg.bottom")
               }
               
               VStack(alignment: .leading, spacing: 8) {
                  Text("Plan Your Dream Trip in Minutes")
                     .font(.headline)
                     .bold()
                  
                  Text("Build, personalize, and optimize your itineraries with our trip planner. Perfect for getaways, remote workcations, and any spontaneous escapade.")
                     .font(.caption)
                     .foregroundStyle(Color(uiColor: .rgb(red: 103, green: 110, blue: 126)))
                     .lineSpacing(5)
                  
                  Spacer()
                  
                  // MARK: Create Trip
                  VStack {
                     Button {
                        viewModel.showSelectLocation = true

                     } label: {
                        IconTextView(titleText: "Where to?", subtitleText: "Select City", icon: Image("location.icon"), submissionText: $createTripVm.trip.destination)
                     }
                     .onChange(of: createTripVm.trip.destination, perform: { value in
                        viewModel.trip.destination = value
                        viewModel.updateFormValidity()
                     })
                     
                     HStack {
                        Button {
                           viewModel.showDatePicker = .startDate

                        } label: {
                           IconTextView(titleText: "Start Date", subtitleText: "Enter Date", icon: Image(systemName: "calendar"), submissionText: .constant(viewModel.trip.startDate))
                        }
                        .onChange(of: viewModel.trip.startDate, perform: { value in
                           viewModel.updateFormValidity()
                        })
                        
                        Button {
                           viewModel.showDatePicker = .endDate

                        } label: {
                           IconTextView(titleText: "End Date", subtitleText: "Enter Date", icon: Image(systemName: "calendar"), submissionText: .constant(viewModel.trip.endDate))
                        }
                        .onChange(of: viewModel.trip.endDate, perform: { value in
                           viewModel.updateFormValidity()
                        })
                     }
                     
                     VkPrimaryButton(action: {
                        viewModel.showCreateTrip.toggle()

                     }, title: "Create a Trip", isEnabled: $viewModel.formIsValid)
                  }
                  .padding(.all, 16)
                  .background(.white)
                  .padding(.bottom, 30)
                  .sheet(isPresented: $viewModel.showSelectLocation) {
                     SelectCityView(viewModel: createTripVm,
                                    shouldDismiss: $viewModel.showSelectLocation)
                  }
                  .sheet(isPresented: .constant(viewModel.showDatePicker != nil), content: {
                     if let showDatePicker = viewModel.showDatePicker {
                        DatePicker(
                           showDatePicker == .startDate ? "Start Date" : "End Date",
                           selection: showDatePicker == .startDate ? $viewModel.selectedStartDate : $viewModel.selectedEndDate,
                           displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .onChange(of: viewModel.selectedStartDate) { newValue in
                           if viewModel.showDatePicker == .startDate {
                              viewModel.selectedStartDate = newValue
                           }
                           viewModel.showDatePicker = nil
                        }
                        .onChange(of: viewModel.selectedEndDate) { newValue in
                           if viewModel.showDatePicker == .endDate {
                              viewModel.selectedEndDate = newValue
                           }
                           viewModel.showDatePicker = nil
                        }
                     }
                  })
               }
               .sheet(isPresented: $viewModel.showCreateTrip) {
                  CreateTripView(viewModel: createTripVm,
                                 delegate: viewModel, 
                                 shouldDismiss: $viewModel.showCreateTrip)
               }
               .padding(.top, 20)
               .padding(.horizontal, 20)
               
               if viewModel.isLoading {
                  ProgressView()
               }
            }
            .alert(viewModel.message, isPresented: .constant(!viewModel.message.isEmpty)) {
            }
            
            VStack {
               MyTripsView(tripData: Binding(
                  get: { viewModel.tripData ?? [] },
                  set: { viewModel.tripData = $0 }
               ), tripCategoryData: $viewModel.tripCategoryData,
                           submissionText: $viewModel.selectedTripCategory) { id in
               }
            }
            
            .padding(.horizontal, 16)
            .onAppear {
               if !viewModel.isFetched {
                  viewModel.fetchTrips()
               }
            }
         }
      }
   }
   
   // MARK: Functions
   private func dateBinding(for dateType: TripHomeViewDateType) -> Binding<Date> {
        switch dateType {
        case .startDate:
            return $viewModel.selectedStartDate
        case .endDate:
            return $viewModel.selectedEndDate
        }
    }
}

#Preview {
   NavigationView {
      TripHomeView(viewModel: TripViewModel())
   }
}
