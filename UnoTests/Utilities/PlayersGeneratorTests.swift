//
//  PlayersGeneratorTests.swift
//  UnoTests
//
//  Created by Thibault Klein on 10/18/20.
//

import XCTest
@testable import Uno

final class PlayersGeneratorTests: XCTestCase {
    func testPlayersGenerator_createsPlayersRotation() {
        // given
        let player1 = Player(name: "John", number: 1, cards: [])
        let player2 = Player(name: "Marc", number: 2, cards: [])
        let player3 = Player(name: "David", number: 3, cards: [])
        // when
        let rotation = PlayersGenerator.generatePlayersRotation([player1, player2, player3])
        // then
        XCTAssertFalse(rotation.isEmpty)
        XCTAssertEqual(rotation.first?.value.name, "John")
        XCTAssertEqual(rotation.next()?.value.name, "Marc")
        XCTAssertEqual(rotation.next()?.value.name, "David")
        // Loop back to the first player
        XCTAssertEqual(rotation.next()?.value.name, "John")
    }
}
