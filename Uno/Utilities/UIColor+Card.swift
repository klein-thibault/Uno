//
//  UIColor+Card.swift
//  Uno
//
//  Created by Thibault Klein on 11/13/20.
//

import UIKit

extension UIColor {
    static func cardColor(_ cardColor: CardColor) -> UIColor {
        switch cardColor {
        case .green:
            return .green
            
        case .blue:
            return .blue
            
        case .red:
            return .red
            
        case .yellow:
            return .yellow

        case .black:
            return .black
        }
    }
}
