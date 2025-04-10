//
//  LRUCache.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/9/25.
//

import Foundation

final class LRUCache<Key: Hashable, Value> {
    private let capacity: UInt
    private(set) var cache: [Key: Node<Key, Value>] = [:] // For O(1) reads and writes
    private(set) var list = DoublyLinkedList<Key, Value>() // For LRU implementation
    private let lock = NSLock() // To ensure thread safety and prevent race conditions

    init(capacity: UInt) {
        self.capacity = capacity
    }
    
    // Returns key if present and sets to recently used
    func get(key: Key) -> Value? {
        lock.lock()
        defer { lock.unlock() }
        if let node = cache[key] {
            list.moveToHead(node: node)
            return node.value
        }
        return nil
    }
    
    // Inserts or updates the value for the given key
    func set(key: Key, value: Value) {
        lock.lock()
        defer { lock.unlock() }
        if let node = cache[key] {
            node.value = value
            list.moveToHead(node: node)
        } else {
            let node = Node(key: key, value: value)
            cache[key] = node
            list.insertAtHead(node: node)
            
            // If we exceed capacity, remove the LRU
            if cache.count > capacity, let tail = list.removeTail() {
                print("removing least recently used")
                cache.removeValue(forKey: tail.key)
            }
        }
    }
}

