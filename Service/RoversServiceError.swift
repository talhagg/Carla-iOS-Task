//
//  RoversServiceError.swift
//  CaseService
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation

final class RoversServiceError: LocalizedError {
    enum ErrorType {
        case serviceError(error: Error)
        case serializationError(error: Error)
        case customError(message: String)
    }
    
    let errorType: ErrorType
    
    init(errorType: ErrorType) {
        self.errorType = errorType
    }
    
    var errorDescription: String? {
        switch errorType {
        case .serviceError(let error):
            return "Service Error: \(error.localizedDescription)"
        case .serializationError(let error):
            return "Serialization Error: \(error.localizedDescription)"
        case .customError(let message):
            return "Custom Error: \(message)"
        }
    }
}
