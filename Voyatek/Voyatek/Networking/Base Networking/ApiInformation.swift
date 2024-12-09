//
//  ApiInformation.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation

protocol ApiInformation {
   var path: String { get }
   var method: HTTPMethod { get }
   var headers: [HTTPHeaderField: String] { get }
   var collectionName: String? { get }
   func getEncodedData() -> Encodable?
   func getQueryParameters() -> [String: String]?
   var withApi: Bool { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

extension ApiInformation {
   var headers: [HTTPHeaderField: String] { [.contentType: ContentType.jsonEncoding.rawValue] }
   var collectionName: String? { nil }
   func getEncodedData() -> Encodable? { nil }
   func getQueryParameters() -> [String: String]? { nil }
   var withApi: Bool { false }
}

extension ApiInformation {
   var fullURL: URL? {
      guard let baseURL = AppConfig.currentEnvironment.baseURL else { return nil }
      var finalURL = baseURL
      if withApi {
         finalURL = finalURL.appendingPathComponent("api")
      }
      if let collectionName = collectionName {
         finalURL = finalURL.appendingPathComponent(collectionName)
      }
      finalURL = finalURL.appendingPathComponent(path)
      var urlComponents = URLComponents(url: finalURL, resolvingAgainstBaseURL: false)
      urlComponents?.queryItems = getQueryParameters()?.map { URLQueryItem(name: $0.key, value: $0.value) }
      
      return urlComponents?.url
   }
}
