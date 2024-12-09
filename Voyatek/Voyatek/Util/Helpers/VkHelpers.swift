//
//  VkHelpers.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 09/12/2024.
//

import Foundation

enum VkHelpers {
   public static func delay(durationInSec seconds: Double, completion: @escaping () -> Void) {
      DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
   }
   
   static func updateMain(_ block: @escaping () -> Void) {
      DispatchQueue.main.async {
         block()
      }
   }
}

