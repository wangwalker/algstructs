//
//  TreeTests.swift
//  
//
//  Created by Walker Wang on 2023/12/18.
//

import XCTest
@testable import Tree

final class TreeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
