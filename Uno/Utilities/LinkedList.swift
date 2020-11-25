//
//  LinkedList.swift
//  Uno
//
//  Created by Thibault Klein on 10/18/20.
//

import Foundation

final class Node<Element: Equatable> {
    let value: Element
    var next: Node?
    
    init(value: Element) {
        self.value = value
    }
}

final class LinkedList<Element: Equatable> {
    private var head: Node<Element>?
    private var tail: Node<Element>?
    var current: Node<Element>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: Node<Element>? {
        return head
    }

    var last: Node<Element>? {
        return tail
    }
    
    func append(_ element: Element) {
        let newNode = Node(value: element)

        if let tailNode = tail {
            tailNode.next = newNode
        } else {
            head = newNode
            current = head
        }

        tail = newNode
    }

    @discardableResult
    func next() -> Node<Element>? {
        let next = current?.next
        current = next
        return next
    }
    
    func reverse() {
        let currentNode = current        
        var head = currentNode
        var previous: Node<Element>?
        var next: Node<Element>?
        while (head?.next != nil) || (head?.next?.value != head?.value) {
            next = head?.next
            head?.next = previous
            previous = head
            head = next
        }
        self.head = previous
    }
}
