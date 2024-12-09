//
//  IconTextView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import SwiftUI

struct IconTextView: View {
   let titleText: String
   let subtitleText: String
   let icon: Image
   @Binding var submissionText: String
   
   var body: some View {
      HStack {
         icon
            .font(.callout)
            .foregroundStyle(Color.VkTheme.brandGray)
         
         VStack(alignment: .leading) {
            Text(titleText)
               .font(.caption)
               .foregroundStyle(Color.VkTheme.brandGray)
            
            Text(submissionText.isEmpty ? subtitleText : submissionText)
               .font(.body)
               .bold()
               .foregroundStyle(Color.VkTheme.brandGray)
         }
         
         Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(.leading, 16)
      .background(Color.VkTheme.brandGray.opacity(0.1))
      .frame(height: 86)
      .clipShape(.rect(cornerRadius: K.Dm.defaultCornerRadius))
      .overlay {
         RoundedRectangle(cornerRadius: K.Dm.defaultCornerRadius)
            .stroke(Color.gray.opacity(0.3))
      }
   }
}
