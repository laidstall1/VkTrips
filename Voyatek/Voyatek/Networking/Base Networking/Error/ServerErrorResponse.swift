//
//  ServerErrorResponse.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation

struct ServerErrorResponse: Decodable {
    let errorMessage: String
}

struct ErrorResponse: Decodable {
    let message: String?
}
