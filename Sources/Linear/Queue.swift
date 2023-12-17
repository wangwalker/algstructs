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
