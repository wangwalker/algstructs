//
//  File.swift
//  
//
//  Created by Walker Wang on 2023/12/14.
//

import Foundation
import Linear

public class TreeNode<Key, Value> where Key: Comparable {
    public var key: Key
    public var value: Value
    public var left: TreeNode? {
        didSet {
            update()
        }
    }
    public var right: TreeNode? {
        didSet {
            update()
        }
    }
    public var size: Int = 0

    public init(key: Key, value: Value, size: Int,
                left: TreeNode? = nil, right: TreeNode? = nil) {
        self.key = key
        self.value = value
        self.size = size
        self.left = left
        self.right = right
    }

    public func compare(k: Key) -> ComparisonResult {
        if k < key {
            return .orderedAscending
        } else if k > key {
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }

    private func update() {
        let left = left?.size ?? 0
        let right = right?.size ?? 0
        size = left + right + 1
    }
}

extension TreeNode: Comparable {
    public static func < (lhs: TreeNode<Key, Value>, rhs: TreeNode<Key, Value>) -> Bool {
        lhs.key < rhs.key
    }

    public static func == (lhs: TreeNode<Key, Value>, rhs: TreeNode<Key, Value>) -> Bool {
        lhs.key == rhs.key
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        "key: \(key), value: \(value)"
    }
}

public enum TraverseType {
    case pre
    case `in`
    case post
}

public class BinaryTree<Key, Value> where Key: Comparable {
    var root: TreeNode<Key, Value>?
    var callback: ((TreeNode<Key, Value>) -> Void) = { _ in }

    public init(root: TreeNode<Key, Value>?) {
        self.root = root
    }

    public func traverse(type: TraverseType,
                         callback: @escaping (TreeNode<Key, Value>) -> Void) {
        self.callback = callback
        switch type {
        case .pre: preTraverse(node: root)
        case .in: inTraverse(node: root)
        case .post: postTraverse(node: root)
        }
    }

    private func preTraverse(node: TreeNode<Key, Value>?) {
        guard let root = node else { return }
        var stack = Stack<TreeNode<Key, Value>>()
        stack.push(root)
        while let node = stack.pop() {
            callback(node)
            if let right = node.right {
                stack.push(right)
            }
            if let left = node.left {
                stack.push(left)
            }
        }
    }

    private func inTraverse(node: TreeNode<Key, Value>?) {
        var node = node
        var stack = Stack<TreeNode<Key, Value>>()
        while !stack.isEmpty() || node != nil {
            if node != nil {
                if let node = node {
                    stack.push(node)
                }
                node = node?.left
            } else {
                node = stack.pop()
                if let node = node {
                    callback(node)
                }
                node = node?.right
            }
        }

    }

    private func postTraverse(node: TreeNode<Key, Value>?) {
        guard let node = node else { return }
        var s1 = Stack<TreeNode<Key, Value>>()
        var s2 = Stack<TreeNode<Key, Value>>()
        s1.push(node)
        while !s1.isEmpty() {
            if let head = s1.pop() {
                s2.push(head)
                if let left = head.left {
                    s1.push(left)
                }
                if let right = head.right {
                    s1.push(right)
                }
            }
        }
        while let node = s2.pop() {
            callback(node)
        }
    }
}

