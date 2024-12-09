//
//  VkHelpers.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 09/12/2024.
//

import UIKit

enum VkHelpers {
   static func delay(durationInSec seconds: Double, completion: @escaping () -> Void) {
      DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
   }
   
   static func updateMain(_ block: @escaping () -> Void) {
      DispatchQueue.main.async {
         block()
      }
   }
   
   func imageFromBase64(base64String: String) -> UIImage? {
       if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
           return UIImage(data: imageData)
       }
       return nil
   }
}

