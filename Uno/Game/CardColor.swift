//
//  CardColor.swift
//  Uno
//
//  Created by Thibault Klein on 10/17/20.
//

import Foundation

enum CardColor: CaseIterable {
    case red, blue, yellow, green, black
}

extension CardColor {
    var name: String {
        switch self {
        case .red: return "Red"
        case .blue: return "Blue"
        case .yellow: return "Yellow"
        case .green: return "Green"
        case .black: return "Wild"
        }
    }
}
