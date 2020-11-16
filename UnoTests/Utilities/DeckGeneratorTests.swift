//
//  DeckGeneratorTests.swift
//  UnoTests
//
//  Created by Thibault Klein on 10/17/20.
//

import XCTest
@testable import Uno

final class DeckGeneratorTests: XCTestCase {
    func testDeckGenerator_generatesExpectedDeck() {
        // when
        let deck = DeckGenerator.generateDeck()
        // then
        XCTAssertFalse(deck.isEmpty)
        XCTAssertTrue(deck.elements.count == 108)
    }
}
