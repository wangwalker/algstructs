//
//  File.swift
//  
//
//  Created by Walker Wang on 2023/12/14.
//

import Foundation

public struct Stack<Element> where Element: Comparable & CustomStringConvertible {
    private var items: [Element] = []

    // The top value of stack
    public var top: Element? {
        items.last
    }
    public var size: Int {
        items.count
    }

    public func isEmpty() -> Bool {
        size == 0
    }
    public mutating func push(_ item: Element) {
        items.append(item)
    }
    public mutating func pop() -> Element? {
        return items.popLast()
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
       "[" + items.map { $0.description } .joined(separator: ", ") + "]"
    }
}

extension Stack {
    /// Reverse the stack by just recursively calling push and pop methods
    /// Return the bottom element and remove from the stack.
    private mutating func popBottom() -> Element? {
        if size < 2 {
            return pop()
        }
        guard let top = pop() else {
            return nil
        }
        let result = popBottom()
        push(top)
        return result
    }
    mutating func reverse() {
        guard let bottom = popBottom() else {
            return
        }
        reverse()
        push(bottom)
    }
}

// MinimumStack is an enhanced stack you can get the minimum value
// of the stack at any time after pushing or poping new value.
public struct MinimumStack<Element> where Element: Comparable & CustomStringConvertible {
    private var data = Stack<Element>()
    private var minimum = Stack<Element>()

    public init() {}

    /// if the data stack is [1, 3, 2, 4, 2, 5], then, the minimum stack will be [1] always
    /// if the data stack is [3, 2, 1, 4, 5], then the minimum stack will be [3], [3, 2], [3, 2, 1]
    public mutating func push(_ element: Element) {
        if minimum.isEmpty() {
            minimum.push(element)
        } else if let top = minimum.top {
            if element <= top {
                minimum.push(element)
            }
        }
        data.push(element)
    }

    /// if the data is [1, 3, 2, 4, 2, 5], the minimum is [1]. when pop, it will be the same until the last time.
    /// if the data stack is [3, 2, 1, 4, 5], the minimum is [3, 2, 1]. when pop one by one, the minimum
    /// will be [3, 2, 1], [3, 2, 1], [3, 2], [3], []
    public mutating func pop() -> Element? {
        guard let top = data.pop() else { return nil }
        if let min = minimum.top {
            if min == top {
                _ = minimum.pop()
            }
        }
        return top
    }

    public func min() -> Element? {
        minimum.top
    }

    public var size: Int {
        data.size
    }
}
