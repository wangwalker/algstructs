//
//  File.swift
//  
//
//  Created by Walker Wang on 2023/12/14.
//

import Foundation

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
            return ComparisonResult.orderedAscending
        } else if k > key {
            return ComparisonResult.orderedDescending
        } else {
            return ComparisonResult.orderedSame
        }
    }

    private func update() {
        let left = left?.size ?? 0
        let right = right?.size ?? 0
        size = left + right + 1
    }
}

public class BST<Key, Value> where Key: Comparable {
    public var root: TreeNode<Key,Value>?

    public init(root: TreeNode<Key, Value>) {
        self.root = root
    }

    public func size() -> Int {
        guard let root = root else {
            return 0
        }
        return root.size
    }

    public func isEmpty() -> Bool {
        size() == 0
    }

    public func contains(key: Key) -> Bool {
        get(node: root, key: key) != nil
    }

    public func search(key: Key) -> Value? {
        get(node: root, key: key)
    }

    public func put(key: Key, value: Value) {
        root = put(node: root, key: key, value: value)
    }

    private func get(node: TreeNode<Key, Value>?, key: Key) -> Value? {
        guard let nodeKey = node?.key else {
            return nil
        }
        if key < nodeKey {
            return get(node: node?.left, key: key)
        } else if key > nodeKey {
            return get(node: node?.right, key: key)
        } else {
            return node?.value
        }
    }

    private func put(node: TreeNode<Key, Value>?, key: Key, value: Value) -> TreeNode<Key, Value> {
        guard let node = node else {
            return TreeNode(key: key, value: value, size: 1)
        }
        let cmp = node.compare(k: key)
        switch cmp {
        case ComparisonResult.orderedSame:
            node.value = value
        case ComparisonResult.orderedAscending:
            node.left = put(node: node.left, key: key, value: value)
        case ComparisonResult.orderedDescending:
            node.right = put(node: node.right, key: key, value: value)
        }
        return node
    }
}
