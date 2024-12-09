//
//  ContentView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       NavigationView {
          TripHomeView(viewModel: TripViewModel())
       }
    }
}

#Preview {
    ContentView()
}
