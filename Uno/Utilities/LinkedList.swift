//
//  LinkedList.swift
//  Uno
//
//  Created by Thibault Klein on 10/18/20.
//

import Foundation

final class Node<Element> {
    let value: Element
    var next: Node?
    
    init(value: Element) {
        self.value = value
    }
}

final class LinkedList<Element> {
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

    func next() -> Node<Element>? {
        let next = current?.next
        current = next
        return next
    }
}
