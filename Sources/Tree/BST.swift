//
//  File.swift
//  
//
//  Created by Walker Wang on 2023/12/19.
//

import Foundation

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
