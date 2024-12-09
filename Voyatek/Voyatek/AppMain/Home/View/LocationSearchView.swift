//
//  LocationSearchView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import SwiftUI

struct LocationSearchView: View {
   @Binding var model: Location
   var body: some View {
      HStack {
         Image("location.gray")
            .font(.callout)
            .foregroundStyle(Color.VkTheme.brandGray)
         
         VStack(alignment: .leading) {
            Text(model.location)
               .font(.callout)
               .bold()
               .foregroundStyle(Color.VkTheme.primaryTextColor)
            
            Text(model.city)
               .font(.body)
               .foregroundStyle(Color.VkTheme.brandGray)
         }
         
         Spacer()
         
         VStack {
            Image(model.countryImageUrl)
               .font(.callout)
            
            Text(model.initials)
         }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 16)
      .padding(.top, 10)
   }
}

#Preview {
   LocationSearchView(model: .constant(.init(location: "Laghouat Algeria ", city: "Laghouat", initials: "DZ", countryImageUrl: "")))
}

