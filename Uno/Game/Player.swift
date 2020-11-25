//
//  Player.swift
//  Uno
//
//  Created by Thibault Klein on 10/17/20.
//

import Foundation

class Player {
    let name: String
    let number: Int
    var cards: [Card]

    var isUno: Bool {
        return cards.count == 1
    }

    var isWinner: Bool {
        return cards.isEmpty
    }

    init(name: String, number: Int, cards: [Card] = []) {
        self.name = name
        self.number = number
        self.cards = cards
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Player: CustomStringConvertible {
    var description: String {
        return "\(name)"
    }
}
