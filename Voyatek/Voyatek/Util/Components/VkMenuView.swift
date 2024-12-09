//
//  VkMenuView.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import SwiftUI

struct VkMenuView: View {
   var placeholder: String
   @Binding var title: String
   var options: [String]
   var hasBorder: Bool
   @Binding var isLoading: Bool
   @FocusState var becomeResponder: Bool
   
  
   init(placeholder: String, 
        title: Binding<String>,
        options: [String],
        hasBorder: Bool = true,
        isLoading: Binding<Bool> = .constant(false),
        becomeResponder: FocusState<Bool> = FocusState()) {
      self.placeholder = placeholder
      self._title = title
      self.options = options
      self._isLoading = isLoading
      self.hasBorder = hasBorder
      self._becomeResponder = becomeResponder
   }
   
   var body: some View {
      Menu {
         ForEach(options, id: \.self) { option in
            Button(option) {
               title = option
            }
         }
      } label: {
         HStack {
            Text(title.isEmpty ? placeholder : title)
               .font(.body)
               .fontWeight(.semibold)
               .lineLimit(1)
               .foregroundColor(title.isEmpty ? Color.VkTheme.primaryTextColor.opacity(0.5): .VkTheme.primaryTextColor)
               .padding(.leading, 6)
            
            Spacer()
            
            if !isLoading {
               Image(systemName: "chevron.down")
                  .font(.callout)
                  .foregroundStyle(Color.VkTheme.brandGray)
                  .padding(.trailing, 14)
               
            } else {
               ProgressView()
                  .padding(.trailing, 10)
            }
         }
         .frame(maxWidth: .infinity)
         .frame(height: 50)
         .background(.white)
         .clipShape(.rect(cornerRadius: 8))
         .padding(.horizontal, 8)
         .overlay {
            hasBorder ?
            RoundedRectangle(cornerRadius: 4)
               .stroke(becomeResponder ?
                       Color.VkTheme.brandBlue :
                        Color.VkTheme.brandGray.opacity(0.5), lineWidth: becomeResponder ? 2 : 1)
            : nil
         }
      }
   }
}

#Preview {
   @State var title = "WWW"
   return VkMenuView(placeholder: "Select industry", title: $title, options: ["egg", "rice"])
}
