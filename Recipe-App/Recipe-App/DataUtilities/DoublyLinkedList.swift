//
//  DoublyLinkedList.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/9/25.
//

import Foundation

final class Node<Key: Hashable, Value> {
    var key: Key
    var value: Value
    var prev: Node?
    var next: Node?
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}

final class DoublyLinkedList<Key: Hashable, Value> {
    private(set) var head: Node<Key, Value>?
    private(set) var tail: Node<Key, Value>?
    
    func insertAtHead(node: Node<Key, Value>) {
        node.next = head
        node.prev = nil
        head?.prev = node
        head = node
        if tail == nil {
            tail = node
        }
    }
    
    func remove(node: Node<Key, Value>) {
        if node === head {
            head = node.next
        }
        if node === tail {
            tail = node.prev
        }
        node.prev?.next = node.next
        node.next?.prev = node.prev
        node.prev = nil
        node.next = nil
    }
    
    // Move a node to the head (recently used)
    func moveToHead(node: Node<Key, Value>) {
        remove(node: node)
        insertAtHead(node: node)
    }
    
    // Remove and return the tail node (least recently used)
    func removeTail() -> Node<Key, Value>? {
        guard let tailNode = tail else { return nil }
        remove(node: tailNode)
        return tailNode
    }
}
