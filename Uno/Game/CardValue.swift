//
//  CardValue.swift
//  Uno
//
//  Created by Thibault Klein on 10/17/20.
//

import Foundation

enum CardValue: Int, CaseIterable {
    case zero,
         one,
         two,
         three,
         four,
         five,
         six,
         seven,
         eight,
         nine,
         draw2,
         skip,
         reverse,
         draw4,
         wild
}

extension CardValue {
    var points: Int {
        switch self {
        case .draw2, .skip, .reverse:
            return 20
            
        case .draw4, .wild:
            return 50
        
        default:
            return rawValue
        }
    }
    
    var name: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .draw2: return "Draw"
        case .skip: return "Skip"
        case .reverse: return "Reverse"
        case .draw4: return "Draw"
        case .wild: return ""
        }
    }
}
