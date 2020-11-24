//
//  UnoGameplay.swift
//  Uno
//
//  Created by Thibault Klein on 11/23/20.
//

struct UnoGameplay {
    func currentPlayer(game: Game) -> Player {
        return game.players.current!.value
    }

    func drawCardFromPile(game: Game) -> Card {
        return game.drawCard()
    }
    
    func addCardToPlayerHand(game: Game, card: Card) -> Player {
        let currentPlayer = self.currentPlayer(game: game)
        currentPlayer.cards.append(card)
        return currentPlayer
    }
}
