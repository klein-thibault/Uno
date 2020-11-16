//
//  Card.swift
//  Uno
//
//  Created by Thibault Klein on 10/17/20.
//

import Foundation

class Card {
    let value: CardValue
    let color: CardColor
    
    init?(value: CardValue, color: CardColor) {
        if color == .black && (value != .draw4 && value != .wild) {
            return nil
        }
        if (value == .draw4 || value == .wild) && color != .black {
            return nil
        }
        
        self.value = value
        self.color = color
    }
}

extension Card {
    var quantityInDeck: Int {
        switch (color, value) {
        case (_ , .zero):
            return 1
        case (.black, _):
            return 4
        default:
            return 2
        }
    }

    var isValidFirstCard: Bool {
        return color != .black
            && (value != .draw2
                    || value != .reverse
                    || value != .skip)
    }

    var isANumberCard: Bool {
        let numberValues: [CardValue] = [
            .zero,
            .one,
            .two,
            .three,
            .four,
            .five,
            .six,
            .seven,
            .eight,
            .nine
        ]

        return numberValues.contains(value)
    }
    
    var imageName: String {
        let colorName = color.name
        let valueName = value.name
        
        var result = colorName
        if !valueName.isEmpty {
            result += "_\(valueName)"
        }
        
        return result
    }
}

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color && lhs.value == rhs.value
    }
}

extension Card: CustomStringConvertible {
    var description: String {
        return "\(value.name) \(color.name)"
    }
}
