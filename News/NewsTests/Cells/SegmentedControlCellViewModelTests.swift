//
//  SegmentedControlCellViewModelTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
@testable import News

class SegmentedControlCellViewModelTests: XCTestCase {
    
    let sut = SegmentedControlCellViewModel(title: "title")
    
    func test_init() {
        XCTAssertEqual(sut.cellIdentifier, "SegmentedControlCell")
        XCTAssertFalse(sut.isSelected)
        XCTAssertEqual(sut.title, "title")
    }

}
