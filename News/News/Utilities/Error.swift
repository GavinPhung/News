//
//  Error.swift
//  News
//
//  Created by Gavin Phung on 10/04/2021.
//

import Foundation

enum CustomError: Error {
    case badResponse, decodeError, noImage, noResults
    case badStatusCode (Int)
    
    var message: String {
        switch self {
        case .badResponse:
            return "Bad response"
        case .badStatusCode(let code):
            return "Error code \(code)"
        case .noResults:
            return "No results found"
        case .decodeError:
            return "Decode error"
        case .noImage:
            return "No image found"
        }
    }
}
