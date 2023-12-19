//
//  TreeTests.swift
//  
//
//  Created by Walker Wang on 2023/12/18.
//

import XCTest
@testable import Tree

final class TreeTests: XCTestCase {

    private var tree: BinaryTree<String, Int> {
        ///                 1
        ///             /                   \
        ///          2                                   5
        ///       /         \                           /
        ///     3                 4                  6
        let n3 = TreeNode(key: "3", value: 3, size: 1)
        let n4 = TreeNode(key: "4", value: 4, size: 1)
        let n2 = TreeNode(key: "2", value: 2, size: 3, left: n3, right: n4)
        let n6 = TreeNode(key: "6", value: 6, size: 1)
        let n5 = TreeNode(key: "5", value: 5, size: 2, left: n6)
        let n1 = TreeNode(key: "1", value: 1, size: 6, left: n2, right: n5)
        return BinaryTree(root: n1)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBinaryTreePreTraverse() {
        // GIVEN
        let tree = tree

        // WHEN
        var results: [Int] = []
        tree.traverse(type: .pre) { node in
            results.append(node.value)
        }

        // THEN
        XCTAssertNotNil(tree.root)
        XCTAssertEqual(results, [1, 2, 3, 4, 5, 6])
    }

    func testBinaryTreeInTraverse() {
        // GIVEN
        let tree = tree

        // WHEN
        var results: [Int] = []
        tree.traverse(type: .in) { node in
            results.append(node.value)
        }

        // THEN
        XCTAssertNotNil(tree.root)
        XCTAssertEqual(results, [3, 2, 4, 1, 6, 5])
    }

    func testBinaryTreePostTraverse() {
        // GIVEN
        let tree = tree

        // WHEN
        var results: [Int] = []
        tree.traverse(type: .post) { node in
            results.append(node.value)
        }

        // THEN
        XCTAssertNotNil(tree.root)
        XCTAssertEqual(results, [3, 4, 2, 6, 5, 1])
    }

    func testBSTCreate() {
        // GIVEN
        let root = TreeNode(key: "G", value: 12, size: 1)
        let bst = BST(root: root)

        // WHNE and THEN
        XCTAssertNotNil(bst.root)
        XCTAssertNil(bst.root?.left)
        XCTAssertNil(bst.root?.right)
        XCTAssertFalse(bst.isEmpty())
        XCTAssertTrue(bst.contains(key: root.key))
        XCTAssertEqual(bst.search(key: root.key), root.value)
    }

    func testBSTPutNewKey() {
        // GIVEN
        let root = TreeNode(key: "G", value: 12, size: 1)
        let bst = BST(root: root)

        // WHEN
        let left = TreeNode(key: "D", value: 5, size: 1)
        let right = TreeNode(key: "K", value: 17, size: 1)
        bst.put(key: left.key, value: left.value)
        bst.put(key: right.key, value: right.value)

        // THNE
        XCTAssertNotNil(bst.root?.left)
        XCTAssertNotNil(bst.root?.right)
        XCTAssertEqual(bst.size(), 3)
        XCTAssertTrue(bst.contains(key: left.key))
        XCTAssertTrue(bst.contains(key: right.key))
        XCTAssertEqual(bst.search(key: left.key), left.value)
        XCTAssertEqual(bst.search(key: right.key), right.value)
    }

}
