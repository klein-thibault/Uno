//
//  Stack.swift
//  Uno
//
//  Created by Thibault Klein on 10/17/20.
//

import Foundation

final class Stack<Element> {
    private(set) var elements: [Element] = []
    
    var isEmpty: Bool {
        return elements.isEmpty
    }

    func push(_ element: Element) {
        elements.append(element)
    }
    
    func pop() -> Element? {
        return elements.popLast()
    }
    
    func peek() -> Element? {
        return elements.last
    }
    
    func shuffle() {
        elements.shuffle()
    }
}
