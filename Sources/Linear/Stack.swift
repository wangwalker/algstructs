//
//  File.swift
//  
//
//  Created by Walker Wang on 2023/12/14.
//

import Foundation

public struct Stack<Element: CustomStringConvertible> {
    private var items: [Element] = []
    public var top: Element? {
        return items.last
    }
    public var size: Int {
        return items.count
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
