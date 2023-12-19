//
//  File.swift
//  
//
//  Created by Walker Wang on 2023/12/14.
//

import Foundation

public struct Queue<Element> where Element: CustomStringConvertible {
    private var items: [Element] = []
    public var size: Int {
        return items.count
    }

    public init() { }

    public mutating func enqueue(_ item: Element) {
        items.append(item)
    }
    public mutating func dequeue() -> Element? {
        if items.isEmpty {
            return nil
        }
        let item = items.first
        items.remove(at: 0)
        return item
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
       "[" + items.map { $0.description } .joined(separator: ", ") + "]"
    }
}

// StackedQueue is a queue consisted of two stacks. The main idea behind of this
// is always keep all in one stack, except when dequeuing one, pop all and push
// into another stack, and pop one as the result, popping and pushing back to the
// first stack.
struct StackedQueue<Element> where Element: Comparable & CustomStringConvertible {
    private var pushed = Stack<Element>()
    private var popped = Stack<Element>()

    var size: Int { pushed.size }

    mutating func enqueue(_ item: Element) {
        pushed.push(item)
    }

    mutating func dequeue() -> Element? {
        if pushed.size < 2 {
            return pushed.pop()
        }
        while let e = pushed.pop() {
            popped.push(e)
        }
        let result = popped.pop()
        while let e = popped.pop() {
            pushed.push(e)
        }
        return result
    }
}
