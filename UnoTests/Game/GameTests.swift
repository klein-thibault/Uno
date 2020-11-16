//
//  GameTests.swift
//  UnoTests
//
//  Created by Thibault Klein on 11/2/20.
//

import XCTest
@testable import Uno

class GameTests: XCTestCase {
    let players = [
        Player(name: "John", cards: []),
        Player(name: "Marc", cards: []),
        Player(name: "Catherine", cards: [])
    ]

    func testGame_generateGame() {
        // when
        let game = Game.generateGame(withPlayers: players)
        // then
        XCTAssertFalse(game.players.isEmpty)
        XCTAssertFalse(game.unplayedCardsStack.isEmpty)
        XCTAssertEqual(game.currentRound, 1)
        XCTAssertEqual(game.numberOfPlayers, players.count)
    }

    func testGame_startGame_allPlayersShouldHave7Cards() {
        // given
        let unplayedCards = DeckGeneratorHelper.generateDeckUnshuffled()
        let playedCards = Stack<Card>()
        let game = Game(players: PlayersGenerator.generatePlayersRotation(players),
                        unplayedCardsStack: unplayedCards,
                        playedCardsStack: playedCards,
                        currentRound: 1,
                        numberOfPlayers: players.count)
        // when
        game.start()
        // then
        XCTAssertEqual(game.players.current?.value.cards.count, 7)
        XCTAssertEqual(game.players.next()?.value.cards.count, 7)
        XCTAssertEqual(game.players.next()?.value.cards.count, 7)
    }

    func testGame_startGame_drawFirstCard_whenFirstCardCanBeUsedToStart() throws {
        // given
        let unplayedCards = Stack<Card>()
        unplayedCards.push(Card(value: .zero, color: .blue)!)
        let playedCards = Stack<Card>()
        let game = Game(players: PlayersGenerator.generatePlayersRotation(players),
                        unplayedCardsStack: unplayedCards,
                        playedCardsStack: playedCards,
                        currentRound: 1,
                        numberOfPlayers: players.count)
        // when
        game.drawInitialCard()
        // then
        let playedCard = try XCTUnwrap(game.playedCardsStack.peek())
        XCTAssertTrue(playedCard.isValidFirstCard)
        // The first card in the pile was valid, only 1 card was drawn
        XCTAssertEqual(game.playedCardsStack.elements.count, 1)
    }

    func testGame_startGame_drawFirstCard_whenFirstCardCannotBeUsedToStart() throws {
        // given
        let unplayedCards = Stack<Card>()
        unplayedCards.push(Card(value: .zero, color: .blue)!)
        unplayedCards.push(Card(value: .draw4, color: .black)!)
        let playedCards = Stack<Card>()
        let game = Game(players: PlayersGenerator.generatePlayersRotation(players),
                        unplayedCardsStack: unplayedCards,
                        playedCardsStack: playedCards,
                        currentRound: 1,
                        numberOfPlayers: players.count)
        // when
        game.drawInitialCard()
        // then
        let playedCard = try XCTUnwrap(game.playedCardsStack.peek())
        XCTAssertTrue(playedCard.isValidFirstCard)
        // Had to put the first card in the played card pile and draw another card
        XCTAssertEqual(game.playedCardsStack.elements.count, 2)
    }
}
