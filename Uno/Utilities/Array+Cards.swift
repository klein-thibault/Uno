//
//  Array+Cards.swift
//  Uno
//
//  Created by Thibault Klein on 11/2/20.
//

import Foundation

extension Array where Element: Equatable {
    mutating func removeCard(_ card: Element) {
        if let index = self.firstIndex(where: { $0 == card }) {
            remove(at: index)
        }
    }
}
