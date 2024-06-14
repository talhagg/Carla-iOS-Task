//
//  ErrorHandler.swift
//  CaseService
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import Alamofire

protocol ErrorHandling {
    func handleError<T>(error: Error, completion: @escaping (Result<T, RoversServiceError>) -> Void)
}

class ErrorHandler: ErrorHandling {
    func handleError<T>(error: Error, completion: @escaping (Result<T, RoversServiceError>) -> Void) {
        if let afError = error as? AFError {
            switch afError {
            case .responseValidationFailed(let reason):
                switch reason {
                case .unacceptableStatusCode(let code):
                    let statusCodeError = RoversServiceError(errorType: .serviceError(error: NSError(domain: "HTTPStatusCodeDomain", code: code, userInfo: nil)))
                    print(statusCodeError.errorDescription ?? "Unknown error")
                    completion(.failure(statusCodeError))
                default:
                    let serviceError = RoversServiceError(errorType: .serviceError(error: error))
                    print(serviceError.errorDescription ?? "Unknown error")
                    completion(.failure(serviceError))
                }
            default:
                let serviceError = RoversServiceError(errorType: .serviceError(error: error))
                print(serviceError.errorDescription ?? "Unknown error")
                completion(.failure(serviceError))
            }
        } else if let decodingError = error as? DecodingError {
            let serializationError = RoversServiceError(errorType: .serializationError(error: decodingError))
            print(serializationError.errorDescription ?? "Unknown error")
            completion(.failure(serializationError))
        } else {
            let serviceError = RoversServiceError(errorType: .serviceError(error: error))
            print(serviceError.errorDescription ?? "Unknown error")
            completion(.failure(serviceError))
        }
    }
}
