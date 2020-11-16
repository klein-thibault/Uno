//
//  DeckGenerator.swift
//  Uno
//
//  Created by Thibault Klein on 10/17/20.
//

import Foundation

struct DeckGenerator {
    static func generateDeck() -> Stack<Card> {
        let deck = Stack<Card>()

        for color in CardColor.allCases {
            for value in CardValue.allCases {
                if color == .black {
                    if let card = WildCard(value: value, color: color) {
                        var cardQuantity = card.quantityInDeck
                        
                        while cardQuantity > 0 {
                            deck.push(card)
                            cardQuantity -= 1
                        }
                    }
                } else {
                    if let card = Card(value: value, color: color) {
                        var cardQuantity = card.quantityInDeck
                        
                        while cardQuantity > 0 {
                            deck.push(card)
                            cardQuantity -= 1
                        }
                    }
                }
            }
        }
        
        deck.shuffle()
        
        return deck
    }
}
