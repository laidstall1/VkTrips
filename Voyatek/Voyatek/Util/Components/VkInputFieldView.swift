//
//  VkInputFieldView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 09/12/2024.
//

import SwiftUI

struct VkInputFieldView<Content: View>: View {
   let label: String
   let textField: Content
   @Binding var errorMessage: String
   
   init(label: String, textField: Content, errorMessage: Binding<String> = .constant("")) {
      self.label = label
      self.textField = textField
      self._errorMessage = errorMessage
   }
   
   var body: some View {
      VStack(alignment: .leading, spacing: 10) {
         Text(label)
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(Color.VkTheme.primaryTextColor)
         
         VStack(alignment: .leading, spacing: 4) {
            textField
            
            if !errorMessage.isEmpty {
               Text(errorMessage)
                  .font(.caption)
                  .foregroundStyle(Color.red.opacity(0.7))
            }
         }
      }
   }
   //   MARK: Functions
}
