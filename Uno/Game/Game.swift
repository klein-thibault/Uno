//
//  Game.swift
//  Uno
//
//  Created by Thibault Klein on 10/17/20.
//

import Foundation

protocol GameDelegate: AnyObject {
    func askForWildCardColor(_ wildCard: WildCard)
    func renderPlayerCards(_ player: Player)
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
        handleSpecialCard(card)
        
        if player.isWinner {
            // FINISH GAME
            print("Player \(player.name) won!")
        }
        
        players.next()

        return true
    }
    
    func skipTurn() {
        _ = players.next()
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
    
    private func handleSpecialCard(_ card: Card) {
        switch card.value {
        case .skip:
            players.next()
        case .reverse:
            if numberOfPlayers > 2 {
                players.reverse()
            } else {
                players.next()
            }
        case .draw2:
            let card1 = drawCard()
            let card2 = drawCard()
            if let nextPlayer = players.current?.next?.value {
                nextPlayer.cards.append(contentsOf: [card1, card2])
                delegate?.renderPlayerCards(nextPlayer)
            }
            players.next()
        case .draw4:
            break
        case .wild:
            if let wildCard = card as? WildCard {
                delegate?.askForWildCardColor(wildCard)
            }
        default:
            break
        }
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

        while round < 7 {
            for _ in 1...numberOfPlayers {
                let player = players.current?.value
                let card = drawCard()
                player?.cards.append(card)
                print("Player \(player!.name) got card \(card.description) during round \(round)")
                players.next()
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
