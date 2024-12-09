//
//  VkSessionHandler.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import Alamofire
import Foundation

struct VkSessionHandler {
   static let sessionManager: Session = {
       let configuration = URLSessionConfiguration.af.default
       configuration.timeoutIntervalForRequest = 30
       return Session(
           configuration: configuration,
           interceptor: nil,
           eventMonitors: [NetworkLogger()])
   }()
}
