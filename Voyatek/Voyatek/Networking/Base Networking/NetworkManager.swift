//
//  NetworkService.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 07/12/2024.
//

import Foundation
import Alamofire

class NetworkManager<Target: ApiInformation> {
   private let requestHandler: RequestHandler
   private let sessionHandler: Session
   
   init(requestHandler: RequestHandler,
        sessionHandler: Session = VkSessionHandler.sessionManager) {
      self.requestHandler = requestHandler
      self.sessionHandler = sessionHandler
   }
   
   func fetchRequest<T: Decodable>(type: T.Type,
                                   apiInformation: Target) async throws -> T {
      do {
         let request = try requestHandler.createRequest(from: apiInformation)
         
         let response = await sessionHandler.request(request)
            .serializingDecodable(T.self)
            .response
         
         switch response.result {
         case .success(let data):
            return data
         case .failure(let error):
            throw handleError(error: error, data: response.data)
         }
      } catch {
         throw handleGeneralError(error: error)
      }
   }
   
   private func handleError(error: AFError, data: Data?) -> ApiError {
      if let urlError = error.underlyingError as? URLError {
         switch urlError.code {
         case .notConnectedToInternet, .timedOut:
            return .NoNetwork
         default:
            break
         }
      }
      
      if error.isSessionTaskError {
         return .NoNetwork
      }
      
      if let data = data {
         if let decodingError = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
            return .StatusMessage(decodingError.errorMessage)
         }
         
         if let genericError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
            return .StatusMessage(genericError.message ?? "Unknown error occurred")
         }
         
         if data.isEmpty {
            return .NoData
         }
      }
      return .ServerError
   }
    
    private func handleGeneralError(error: Error) -> ApiError {
       if let apiError = error as? ApiError {
          return apiError
       }
       return .General
    }
}
