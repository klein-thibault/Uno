//
//  Game.swift
//  Uno
//
//  Created by Thibault Klein on 10/17/20.
//

import Foundation

protocol GameDelegate: AnyObject {
    func askForWildCardColor(_ wildCard: WildCard)
}

class Game {
    let players: LinkedList<Player>
    var unplayedCardsStack: Stack<Card>
    var playedCardsStack: Stack<Card>
    var currentRound: Int
    var numberOfPlayers: Int
    
    var activeCard: Card? {
        return playedCardsStack.peek()
    }
    
    weak var delegate: GameDelegate?
    
    init(players: LinkedList<Player>,
         unplayedCardsStack: Stack<Card>,
         playedCardsStack: Stack<Card>,
         currentRound: Int,
         numberOfPlayers: Int) {
        self.players = players
        self.unplayedCardsStack = unplayedCardsStack
        self.playedCardsStack = playedCardsStack
        self.currentRound = currentRound
        self.numberOfPlayers = numberOfPlayers
    }

    static func generateGame(withPlayers players: [Player]) -> Game {
        return Game(players: PlayersGenerator.generatePlayersRotation(players),
                    unplayedCardsStack: DeckGenerator.generateDeck(),
                    playedCardsStack: Stack<Card>(),
                    currentRound: 1,
                    numberOfPlayers: players.count)
    }

    func start() {
        deal()
        drawInitialCard()
        // TODO: Start player rotation
    }

    func play(player: Player, card: Card) -> Bool {
        guard let visibleCard = playedCardsStack.peek() else {
            return false
        }
        
        guard isPlayerTurn(player) else {
            return false
        }
        
        guard canPlayCard(card, onTopOfCard: visibleCard) else {
            return false
        }

        playedCardsStack.push(card)
        player.cards.removeCard(card)
        
        if card.value == .skip {
            _ = players.next()
        }
        
        if card.value == .reverse {
            // TODO: implement previous player in linked list
        }

        _ = players.next()

        if player.isWinner {
            // FINISH GAME
            print("Player \(player.name) won!")
        }
        
        if let wildCard = card as? WildCard {
            delegate?.askForWildCardColor(wildCard)
        }

        return true
    }

    func drawCard() -> Card {
        if !unplayedCardsStack.isEmpty {
            return unplayedCardsStack.pop()!
        } else {
            rebuildDrawPile()
            return unplayedCardsStack.pop()!
        }
    }

    func canPlayCard(_ playedCard: Card, onTopOfCard activeCard: Card) -> Bool {
        if playedCard.color == activeCard.color {
            return true
        }
        
        if let wildCard = activeCard as? WildCard, wildCard.selectedColor == playedCard.color {
            return true
        }

        if playedCard.value == activeCard.value && activeCard.color != .black {
            return true
        }

        if playedCard.value == .wild {
            return true
        }
        
        if playedCard.value == .draw4 {
            // TODO
            return false
        }

        return false
    }
    
    func isPlayerTurn(_ player: Player) -> Bool {
        return player == players.current?.value
    }

    // MARK: - Game Setup Functions

    func drawInitialCard() {
        while let card = unplayedCardsStack.peek(), !card.isValidFirstCard {
            let drawnCard = drawCard()
            playedCardsStack.push(drawnCard)
        }

        let initialCard = drawCard()
        playedCardsStack.push(initialCard)
    }

    private func deal() {
        var round = 0

        while round != 7 {
            for _ in 1...numberOfPlayers {
                let player = players.next()?.value
                let card = drawCard()
                player?.cards.append(card)
            }
            round += 1
        }
    }

    private func rebuildDrawPile() {
        playedCardsStack.shuffle()
        while let card = playedCardsStack.pop() {
            unplayedCardsStack.push(card)
        }
    }
}
