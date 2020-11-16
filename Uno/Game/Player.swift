//
//  Player.swift
//  Uno
//
//  Created by Thibault Klein on 10/17/20.
//

import Foundation

class Player {
    let name: String
    var cards: [Card]

    var isUno: Bool {
        return cards.count == 1
    }

    var isWinner: Bool {
        return cards.isEmpty
    }

    init(name: String, cards: [Card] = []) {
        self.name = name
        self.cards = cards
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}
