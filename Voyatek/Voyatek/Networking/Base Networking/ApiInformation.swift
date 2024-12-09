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
}

extension ApiInformation {
   var fullURL: URL? {
      guard let baseURL = AppConfig.currentEnvironment.baseURL else { return nil }
      var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
      urlComponents?.queryItems = getQueryParameters()?.map { URLQueryItem(name: $0.key, value: $0.value) }
      return urlComponents?.url
   }
}
