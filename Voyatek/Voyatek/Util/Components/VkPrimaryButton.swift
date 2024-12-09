//
//  VkPrimaryButton.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import SwiftUI

struct VkPrimaryButton: View {
   var action: () -> Void
   let title: String
   let tint: Color = .VkTheme.brandBlue
   let bgColor: Color = .white
   @Binding var isEnabled: Bool
   @Binding var isLoading: Bool
   @State var flip = false
   
   init(action: @escaping () -> Void, title: String, isEnabled: Binding<Bool> = .constant(true), flip: Bool = false, isLoading: Binding<Bool> = .constant(false)) {
      self.action = action
      self.title = title
      self._isEnabled = isEnabled
      self.flip = flip
      self._isLoading = isLoading
   }
   
   var body: some View {
      ZStack(alignment: .center) {
         Button(action: action, label: {
            Text(isLoading ? "" : title)
               .font(.body)
               .fontWeight(.medium)
               .padding()
               .frame(height: 60)
               .frame(maxWidth: .infinity)
               .background(flip ? bgColor : tint)
               .clipShape(.rect(cornerRadius: 4))
               .foregroundStyle(flip ? tint : bgColor)
         })
         .tint(flip ? bgColor : tint)
         .opacity(isEnabled ? 1 : 0.5)
         .disabled(!isEnabled)
         
         if isLoading {
            ProgressView()
         }
      }
   }
}
