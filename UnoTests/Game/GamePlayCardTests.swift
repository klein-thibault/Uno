//
//  GamePlayCardTests.swift
//  UnoTests
//
//  Created by Thibault Klein on 11/15/20.
//

import XCTest
@testable import Uno

final class GamePlayCardTests: GameTests {
    func testGame_playCard_whenCardIsValid() {
        // given
        let player = players[0]
        let card = Card(value: .zero, color: .blue)!
        player.cards = [Card(value: .three, color: .red)!, Card(value: .five, color: .yellow)!, card]
        let unplayedCards = Stack<Card>()
        let playedCards = Stack<Card>()
        playedCards.push(Card(value: .two, color: .blue)!)
        let game = Game(players: PlayersGenerator.generatePlayersRotation(players),
                        unplayedCardsStack: unplayedCards,
                        playedCardsStack: playedCards,
                        currentRound: 1,
                        numberOfPlayers: players.count)
        // when
        _ = game.play(player: player, card: card)
        // then
        XCTAssertEqual(game.playedCardsStack.peek()!, card)
        XCTAssertEqual(player.cards.count, 2)
    }
    
    func testGame_playCard_playerIsUno() {
        // given
        let player = players[0]
        let card = Card(value: .zero, color: .blue)!
        player.cards = [Card(value: .five, color: .yellow)!, card]
        let unplayedCards = Stack<Card>()
        let playedCards = Stack<Card>()
        playedCards.push(Card(value: .two, color: .blue)!)
        let game = Game(players: PlayersGenerator.generatePlayersRotation(players),
                        unplayedCardsStack: unplayedCards,
                        playedCardsStack: playedCards,
                        currentRound: 1,
                        numberOfPlayers: players.count)
        // when
        _ = game.play(player: player, card: card)
        // then
        XCTAssertEqual(game.playedCardsStack.peek()!, card)
        XCTAssertTrue(player.isUno)
    }
    
    func testGame_playCard_playerWins() {
        // given
        let player = players[0]
        let card = Card(value: .zero, color: .blue)!
        player.cards = [card]
        let unplayedCards = Stack<Card>()
        let playedCards = Stack<Card>()
        playedCards.push(Card(value: .two, color: .blue)!)
        let game = Game(players: PlayersGenerator.generatePlayersRotation(players),
                        unplayedCardsStack: unplayedCards,
                        playedCardsStack: playedCards,
                        currentRound: 1,
                        numberOfPlayers: players.count)
        // when
        _ = game.play(player: player, card: card)
        // then
        XCTAssertEqual(game.playedCardsStack.peek()!, card)
        XCTAssertTrue(player.isWinner)
    }
    
    func testGame_playCard_whenCardIsInvalid() {
        // given
        let player = players[0]
        let card = Card(value: .zero, color: .red)!
        player.cards = [Card(value: .three, color: .red)!, Card(value: .five, color: .yellow)!, card]
        let unplayedCards = Stack<Card>()
        let playedCards = Stack<Card>()
        playedCards.push(Card(value: .two, color: .blue)!)
        let game = Game(players: PlayersGenerator.generatePlayersRotation(players),
                        unplayedCardsStack: unplayedCards,
                        playedCardsStack: playedCards,
                        currentRound: 1,
                        numberOfPlayers: players.count)
        // when
        _ = game.play(player: player, card: card)
        // then
        XCTAssertNotEqual(game.playedCardsStack.peek()!, card)
        XCTAssertEqual(player.cards.count, 3)
    }
    
    func testGame_playCard_whenNoPlayedCardsAreAvailable() {
        // given
        let player = players[0]
        let card = Card(value: .zero, color: .blue)!
        player.cards = [Card(value: .three, color: .red)!, Card(value: .five, color: .yellow)!, card]
        let unplayedCards = Stack<Card>()
        let playedCards = Stack<Card>()
        let game = Game(players: PlayersGenerator.generatePlayersRotation(players),
                        unplayedCardsStack: unplayedCards,
                        playedCardsStack: playedCards,
                        currentRound: 1,
                        numberOfPlayers: players.count)
        // when
        _ = game.play(player: player, card: card)
        // then
        XCTAssertNil(game.playedCardsStack.peek())
        XCTAssertEqual(player.cards.count, 3)
    }
}