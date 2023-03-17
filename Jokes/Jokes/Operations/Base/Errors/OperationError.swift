//
//  OperationError.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 16.03.2023.
//

import Foundation

public enum OperationError: LocalizedError {
    case noUrlAvailable
    case noDataAvailable
    case cannotParseResponse
    case noInternetConnection
    case operationCancelled
    
    case error(message: String, code: Int?)
    
    public var errorDescription: String {
        switch self {
            case .noUrlAvailable: return "No url available."
            case .noDataAvailable: return "No data available."
            case .cannotParseResponse: return "Cannot parse response."
            case .noInternetConnection: return "No internet connection."
            case .operationCancelled: return ""
            case .error(let message, _): return message
        }
    }
}

extension OperationError: Equatable {
    
}
