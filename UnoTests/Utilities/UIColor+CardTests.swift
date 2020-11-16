//
//  UIColor+CardTests.swift
//  UnoTests
//
//  Created by Thibault Klein on 11/15/20.
//

import XCTest
@testable import Uno

final class UIColorCardTests: XCTestCase {
    func testCardColor() {
        XCTAssertEqual(UIColor.cardColor(.black), .black)
        XCTAssertEqual(UIColor.cardColor(.green), .green)
        XCTAssertEqual(UIColor.cardColor(.blue), .blue)
        XCTAssertEqual(UIColor.cardColor(.red), .red)
        XCTAssertEqual(UIColor.cardColor(.yellow), .yellow)
    }
}
