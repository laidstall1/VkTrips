//
//  Environment.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation

enum Environment {
    case development
    case staging
    case production

    var baseURL: URL? {
        switch self {
        case .development:
            return URL(string: "https://caf80495a53a11b31ed8.free.beeceptor.com")

        default:
           return nil
        }
    }
}

struct AppConfig {
    static let currentEnvironment: Environment = .development
}
