//
//  RequestHandler.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation

protocol RequestHandler {
   func createRequest<Target: ApiInformation>(from apiInfo: Target) throws -> URLRequest
}

class DefaultRequestHandler: RequestHandler {
   func createRequest<Target: ApiInformation>(from apiInfo: Target) throws -> URLRequest {
      guard let fullURL = apiInfo.fullURL else {
         throw ApiError.InvalidUrl
      }
      var request = URLRequest(url: fullURL)
      request.httpMethod = apiInfo.method.rawValue
      
      for (key, value) in apiInfo.headers {
         request.setValue(value, forHTTPHeaderField: key.rawValue)
      }
      
      if let encodedData = apiInfo.getEncodedData() {
         if let contentType = apiInfo.headers[.contentType], contentType == ContentType.jsonEncoding.rawValue {
            request.httpBody = try JSONEncoder().encode(encodedData)
         }
      }
      return request
   }
}

