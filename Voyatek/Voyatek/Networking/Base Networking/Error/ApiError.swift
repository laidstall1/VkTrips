//
//  ApiError.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation

enum ApiError: Error, CustomStringConvertible {
   case DecodingError(String)
   case General
   case NoData
   case NoNetwork
   case ServerError
   case PageNotFound
   case InvalidUrl
   case StatusMessage(String)
   
   private var errorMessager: MessageHelper.ServerError.Type {
      return MessageHelper.ServerError.self
   }
   
   var description: String {
      switch self {
      case .DecodingError(let error):
         return error

      case .General:
         return errorMessager.general

      case .NoData:
         return errorMessager.notFound

      case .NoNetwork:
         return errorMessager.noInternet

      case .ServerError:
         return errorMessager.serverError

      case .StatusMessage(let error):
         return error

      case .PageNotFound:
         return errorMessager.notFound

      case .InvalidUrl:
         return errorMessager.notFound
      }
   }
}
