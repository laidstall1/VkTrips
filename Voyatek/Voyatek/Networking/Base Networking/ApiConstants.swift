//
//  ApiConstants.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
   case jsonEncoding = "application/json"
   case urlEncoding = "application/x-www-form-urlencoded"
   case formData = "multipart/form-data"
}
