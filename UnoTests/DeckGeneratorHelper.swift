//
//  DeckGeneratorHelper.swift
//  UnoTests
//
//  Created by Thibault Klein on 11/2/20.
//

import Foundation
@testable import Uno

struct DeckGeneratorHelper {
    static func generateDeckUnshuffled() -> Stack<Card> {
        let deck = Stack<Card>()

        for color in CardColor.allCases {
            for value in CardValue.allCases {
                if let card = Card(value: value, color: color) {
                    var cardQuantity = card.quantityInDeck

                    while cardQuantity > 0 {
                        deck.push(card)
                        cardQuantity -= 1
                    }
                }
            }
        }

        return deck
    }
}
