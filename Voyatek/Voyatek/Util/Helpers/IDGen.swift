//
//  IDGen.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 09/12/2024.
//

import Foundation

import Foundation

protocol IncrementableIdentifier {
  static func nextID() -> Int
}

extension IncrementableIdentifier {
  private static var currentID: Int {
    get {
      let key = "\(self)"
      if let value = IDStore.currentIDs[key] {
        return value
      } else {
        return 0
      }
    }
    set {
      let key = "\(self)"
      IDStore.currentIDs[key] = newValue
    }
  }
  
  static func nextID() -> Int {
    currentID += 1
    return currentID
  }
   
   func generateRandomInt() -> Int {
       let upperBound = Int.max
       return Int.random(in: 1...upperBound)
   }
}

private struct IDStore {
  static var currentIDs: [String: Int] = [:]
}
