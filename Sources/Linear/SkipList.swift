//
//  File.swift
//  
//
//  Created by Walker Wang on 2023/12/14.
//

import Foundation

public protocol DecisionMaker {
    func shouldInsert() -> Bool
}

public struct RandomDecisionMaker: DecisionMaker {
    public init() { }
    public func shouldInsert() -> Bool {
        (arc4random() % 2) == 0
    }
}

public class SkipListNode<T> where T: Comparable & Equatable {
    public var key: T
    public var data: Any
    public var right: SkipListNode?
    public var down: SkipListNode?

    public init(key: T, data: Any, right: SkipListNode?, down: SkipListNode?) {
        self.key = key
        self.data = data
        self.right = right
        self.down = down
    }
}

extension SkipListNode: CustomStringConvertible {
    public var description: String {
        "key: \(key); data: \(data)"
    }
}

extension SkipListNode: Comparable {
    public static func < (lhs: SkipListNode<T>, rhs: SkipListNode<T>) -> Bool {
        lhs.key < rhs.key
    }

    public static func == (lhs: SkipListNode<T>, rhs: SkipListNode<T>) -> Bool {
        lhs.key == rhs.key
    }
}

public class SkipList<T> where T: Comparable & Equatable {
    public var head: SkipListNode<T>
    public var decisionMaker: DecisionMaker

    public init(head: SkipListNode<T>, decisionMaker: DecisionMaker = RandomDecisionMaker()) {
        self.head = head
        self.decisionMaker = decisionMaker
    }

    public func search(k: T) -> Any? {
        if (k == head.key) {
            return head.data
        }
        var node: SkipListNode? = head
        while (node != nil) {
            if (node?.right != nil && k < node?.key ?? 0 as! T) {
                node = node?.down
            } else if (k == node?.key ?? 0 as! T) {
                return node?.data
            } else {
                node = node?.right
            }
        }
        return 0
    }

    public func insert(k: T, data: Any) {
        var path = Stack<SkipListNode<T>>()
        var node: SkipListNode? = head
        while (node != nil) {
            while (node?.right != nil && k > node?.right?.key ?? 0 as! T) {
                node = node?.right
            }
            path.push(node!)
            node = node?.down
        }
        var down: SkipListNode<T>?
        var shouldInsert = true
        while (shouldInsert && !path.isEmpty()) {
            let currentNode = path.pop()
            currentNode?.right = SkipListNode(key: k, data: data, right: currentNode?.right, down: down)
            down = currentNode?.right // for the last/next level
            shouldInsert = decisionMaker.shouldInsert()
        }
        // check whether need to elevate head node
        if shouldInsert {
            let right = SkipListNode(key: k, data: data, right: nil, down: down)
            head = SkipListNode(key: head.key, data: head.data, right: right, down: head)
        }
    }
}
