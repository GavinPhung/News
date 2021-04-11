//
//  Error.swift
//  News
//
//  Created by Gavin Phung on 10/04/2021.
//

import Foundation

enum CustomError: Error, Equatable {
    case badResponse, decodeError, noResults, error
    case badStatusCode (Int)
    
    var message: String {
        switch self {
        case .badResponse:
            return "Bad response"
        case .badStatusCode(let code):
            return "Error code \(code)"
        case .error:
            return "Error returned"
        case .noResults:
            return "No results found"
        case .decodeError:
            return "Decode error"
        }
    }
}
