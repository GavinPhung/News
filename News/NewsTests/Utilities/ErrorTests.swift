//
//  ErrorTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
@testable import News

class ErrorTests: XCTestCase {

    func test_message() {
        XCTAssertEqual(CustomError.badResponse.message, "Bad response")
        XCTAssertEqual(CustomError.badStatusCode(400).message, "Error code 400")
        XCTAssertEqual(CustomError.badStatusCode(500).message, "Error code 500")
        XCTAssertEqual(CustomError.decodeError.message, "Decode error")
        XCTAssertEqual(CustomError.error.message, "Error returned")
        XCTAssertEqual(CustomError.noResults.message, "No results found")
    }

}
