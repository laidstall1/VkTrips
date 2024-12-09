//
//  VkTextEditorView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 09/12/2024.
//

import SwiftUI

struct VkTextEditorView: View {
   let placeholder: String
   @Binding var submissionText: String
   var limit = 100
   var height: CGFloat
   var validate: ((String) -> Void)?
   @Binding var isValid: Bool
   @Binding var isLoading: Bool
   @FocusState var becomeResponder: Bool
   
   init(placeholder: String,
        submissionText: Binding<String>,
        limit: Int = 100,
        height: CGFloat = 120,
        isLoading: Binding<Bool> = .constant(false),
        isValid: Binding<Bool> = .constant(true),
        validate: ((String) -> Void)? = nil) {
      self._isValid = isValid
      self.placeholder = placeholder
      self._submissionText = submissionText
      self.limit = limit
      self.validate = validate
      self._isLoading = isLoading
      self.height = height
   }
   
   var body: some View {
      ZStack(alignment: .trailing) {
         TextEditor(text: $submissionText)
            .padding(.leading, 8)
            .padding(.top, 8)
            .font(.body)
//            .frame(height: 120)
            .keyboardType(.default)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: K.Dm.defaultCornerRadius))
            .focused($becomeResponder)
            .onChange(of: submissionText, perform: { value in
               if value.count > limit {
                  submissionText = String(value.prefix(limit))
               }
               validate?(value)
            })
         
         if submissionText.isEmpty {
            VStack {
               HStack {
                  Text(placeholder)
                     .font(.body)
                     .foregroundStyle(Color.VkTheme.primaryTextColor.opacity(0.4))
                     .padding(.top, 14)
                     .padding(.leading, 12)
                  
                  Spacer()
               }
               
               Spacer()
            }
            .background(.white)
            .onTapGesture {
               becomeResponder = true
            }
         }
         
         if isLoading {
            ProgressView()
               .padding(.trailing, 10)
         }
      }
      .frame(height: 120)
      .overlay(
         RoundedRectangle(cornerRadius: K.Dm.defaultCornerRadius)
            .stroke(becomeResponder ?
                    Color.VkTheme.brandBlue :
                     Color.VkTheme.brandGray.opacity(0.5), lineWidth: becomeResponder ? 2 : 1)
      )
   }
}

#Preview {
   @State var text = ""
   return VkTextEditorView(placeholder: "Business Description", submissionText: $text, isLoading: .constant(true))
}
