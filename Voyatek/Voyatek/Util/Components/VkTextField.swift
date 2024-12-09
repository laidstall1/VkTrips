//
//  VkTextField.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import SwiftUI

struct VkTextField: View {
   let placeholder: String
   @Binding var submissionText: String
   var limit = 30
   var keyboardType: UIKeyboardType
   var validate: ((String) -> Void)?
   var height: CGFloat
   var cornerRadius: CGFloat
   var icon: Image?
   var hasBorder: Bool
   @Binding var isValid: Bool
   @Binding var isLoading: Bool
   @FocusState var becomeResponder: Bool
   
   init(placeholder: String,
        submissionText: Binding<String>,
        limit: Int = 30,
        keyboardType: UIKeyboardType = .default,
        height: CGFloat = 50,
   cornerRadius: CGFloat = K.Dm.defaultCornerRadius,
        icon: Image? = nil,
        isLoading: Binding<Bool> = .constant(false),
        isValid: Binding<Bool> = .constant(true),
        validate: ((String) -> Void)? = nil,
        hasBorder: Bool = true,
        becomeResponder: FocusState<Bool> = FocusState()) {
      self._isValid = isValid
      self.placeholder = placeholder
      self._submissionText = submissionText
      self.limit = limit
      self.keyboardType = keyboardType
      self.height = height
      self.validate = validate
      self.icon = icon
      self._isLoading = isLoading
      self._becomeResponder = becomeResponder
      self.hasBorder = hasBorder
      self.cornerRadius = cornerRadius
   }
   
   var body: some View {
      ZStack(alignment: .trailing) {
         TextField(placeholder, text: $submissionText)
            .padding(.leading, 10)
            .font(.body)
            .foregroundStyle(Color.VkTheme.primaryTextColor)
            .frame(height: height)
            .keyboardType(keyboardType)
            .background(.white)
            .clipShape(.rect(cornerRadius: cornerRadius))
            .overlay(
               hasBorder ?
                  RoundedRectangle(cornerRadius: cornerRadius)
                  .stroke(
                     becomeResponder ? 
                     Color.VkTheme.brandBlue : .VkTheme.brandGray.opacity(0.6),
                     lineWidth: becomeResponder ? 2 : 1
                  )
               :  nil
            )
            .focused($becomeResponder)
            .onChange(of: submissionText, perform: { value in
               if value.count > limit {
                  submissionText = String(value.prefix(limit))
               }
               //               isValid = value.isEmpty || value.validateCharLength()
               validate?(value)
            })
            
         
         if isLoading {
            ProgressView()
               .padding(.trailing, 10)
         }
         
         // Leading or trailing icon
         if let icon = icon {
            HStack {
               Spacer()
               
               if !isLoading {
                  icon
                     .font(.callout)
                     .padding(.trailing, 10)
               }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
         }
      }
   }
}

#Preview {
   @State var text = ""
   return VkTextField(placeholder: "Password", submissionText: $text, icon: Image(systemName: "chevron.down"), isLoading: .constant(false))
}
