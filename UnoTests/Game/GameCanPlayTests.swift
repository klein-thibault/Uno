//
//  GameCanPlayTests.swift
//  UnoTests
//
//  Created by Thibault Klein on 11/15/20.
//

import XCTest
@testable import Uno

final class GameCanPlayTests: GameTests {
    var game: Game!

    override func setUp() {
        super.setUp()
        game = Game.generateGame(withPlayers: players)
    }

    func testGame_canPlayCard_whenCardCannotBePlayed() {
        // given
        let playedCard = Card(value: .five, color: .blue)!
        let activeCard = Card(value: .six, color: .yellow)!
        // when
        let result = game.canPlayCard(playedCard, onTopOfCard: activeCard)
        // then
        XCTAssertFalse(result)
    }
    
    func testGame_canPlayCard_whenCardCanBePlayedForSameColor() {
        // given
        let playedCard = Card(value: .five, color: .blue)!
        let activeCard = Card(value: .six, color: .blue)!
        // when
        let result = game.canPlayCard(playedCard, onTopOfCard: activeCard)
        // then
        XCTAssertTrue(result)
    }
    
    func testGame_canPlayCard_whenCardCanBePlayedForSameValue() {
        // given
        let playedCard = Card(value: .five, color: .blue)!
        let activeCard = Card(value: .five, color: .yellow)!
        // when
        let result = game.canPlayCard(playedCard, onTopOfCard: activeCard)
        // then
        XCTAssertTrue(result)
    }
    
    func testGame_canPlayCard_wildCard() {
        // given
        let activeCard = Card(value: .five, color: .blue)!
        let playedCard = WildCard(value: .wild, color: .black)!
        // when
        let result = game.canPlayCard(playedCard, onTopOfCard: activeCard)
        // then
        XCTAssertTrue(result)
    }
    
    func testGame_canPlayCard_whenPlayedCardHasSameColorAsWildCardSelectedColor() {
        // given
        let playedCard = Card(value: .five, color: .blue)!
        let activeCard = WildCard(value: .wild, color: .black)!
        activeCard.selectedColor = playedCard.color
        // when
        let result = game.canPlayCard(playedCard, onTopOfCard: activeCard)
        // then
        XCTAssertTrue(result)
    }
}
