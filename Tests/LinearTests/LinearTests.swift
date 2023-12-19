//
//  LinearTests.swift
//  
//
//  Created by Walker Wang on 2023/12/14.
//

import XCTest
@testable import Linear

fileprivate struct MockedDecisionMaker: DecisionMaker {
    var insertFlag = false
    func shouldInsert() -> Bool {
        insertFlag
    }
}

final class LinearTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStackCreateAndIsEmpty() {
        // GIVEN
        let stack = Stack<Int>()

        // WHEN and THEN
        XCTAssertNil(stack.top)
        XCTAssertTrue(stack.isEmpty())
    }

    func testStackPushAndPop() {
        // GIVEN
        var stack = Stack<Int>()

        // WHEN
        stack.push(1)
        stack.push(2)
        stack.push(3)

        // THEN
        XCTAssertFalse(stack.isEmpty())
        XCTAssertEqual(stack.top, 3)
        XCTAssertEqual(stack.size, 3)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 3)
        XCTAssertFalse(stack.isEmpty())
        XCTAssertEqual(stack.top, 2)
        XCTAssertEqual(stack.size, 2)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 2)
        XCTAssertFalse(stack.isEmpty())
        XCTAssertEqual(stack.top, 1)
        XCTAssertEqual(stack.size, 1)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 1)
        XCTAssertTrue(stack.isEmpty())
        XCTAssertEqual(stack.top, nil)
        XCTAssertEqual(stack.size, 0)
    }

    func testMinimumStackPushAndPopSortedValues() {
        // GIVEN
        var stack = MinimumStack<Int>()

        // WHEN push 1, 2, 3
        stack.push(1)
        stack.push(2)
        stack.push(3)

        // THEN
        XCTAssertEqual(stack.size, 3)
        XCTAssertEqual(stack.min(), 1)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 3)
        XCTAssertEqual(stack.min(), 1)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 2)
        XCTAssertEqual(stack.min(), 1)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 1)
        XCTAssertEqual(stack.min(), nil)
    }

    func testMinimumStackPushAndPopNonSortedValues() {
        // GIVEN
        var stack = MinimumStack<Int>()

        // WHEN push 3, 2, 1, 5, 4, 1
        stack.push(3)
        stack.push(2)
        stack.push(1)
        stack.push(5)
        stack.push(4)
        stack.push(1)

        // THEN
        XCTAssertEqual(stack.size, 6)
        XCTAssertEqual(stack.min(), 1)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 1)
        XCTAssertEqual(stack.min(), 1)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 4)
        XCTAssertEqual(stack.min(), 1)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 5)
        XCTAssertEqual(stack.min(), 1)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 1)
        XCTAssertEqual(stack.min(), 2)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 2)
        XCTAssertEqual(stack.min(), 3)

        // WHEN pop and THEN
        XCTAssertEqual(stack.pop(), 3)
        XCTAssertEqual(stack.min(), nil)
    }

    func testQueueCreateAndIsEmpty() {
        // GIVEN
        let queue = Queue<Int>()

        // WHEN and THEN
        XCTAssertEqual(queue.size, 0)
    }

    func testQueueEnqueueAndDequeue() {
        // GIVEN
        var queue = Queue<Int>()

        // WHEN
        queue.enqueue(1)
        queue.enqueue(2)
        queue.enqueue(3)

        // THEN
        XCTAssertEqual(queue.size, 3)

        // WHEN dequeue and THEN
        XCTAssertEqual(queue.dequeue(), 1)
        XCTAssertEqual(queue.size, 2)

        // WHEN dequeue and THEN
        XCTAssertEqual(queue.dequeue(), 2)
        XCTAssertEqual(queue.size, 1)

        // WHEN dequeue and THEN
        XCTAssertEqual(queue.dequeue(), 3)
        XCTAssertEqual(queue.size, 0)
    }

    func testStackedQueueEnqueueAndDequeue() {
        // GIVEN
        var queue = StackedQueue<Int>()

        // WHEN
        queue.enqueue(1)
        queue.enqueue(2)
        queue.enqueue(3)

        // THEN
        XCTAssertEqual(queue.size, 3)

        // WHEN dequeue and THEN
        XCTAssertEqual(queue.dequeue(), 1)
        XCTAssertEqual(queue.size, 2)

        // WHEN dequeue and THEN
        XCTAssertEqual(queue.dequeue(), 2)
        XCTAssertEqual(queue.size, 1)

        // WHEN dequeue and THEN
        XCTAssertEqual(queue.dequeue(), 3)
        XCTAssertEqual(queue.size, 0)
    }

    func testSkipListCreate() {
        // GIVEN
        let skiplist = SkipList(head: SkipListNode(key: 1, data: "a", right: nil, down: nil), decisionMaker: MockedDecisionMaker())

        // WHEN and THEN
        XCTAssertEqual(skiplist.head.key, 1)
        XCTAssertEqual(skiplist.head.data as! String, "a")
        XCTAssertFalse(skiplist.decisionMaker.shouldInsert())
        XCTAssertNil(skiplist.head.right)
        XCTAssertNil(skiplist.head.down)
    }

    func testSkipListInsertWhenFlatIsFalse() {
        // GIVEN
        /// 1 -------------> 7
        /// ↓                   ↓
        /// 1 ----> 4 ----->7
        let decisionMaker = MockedDecisionMaker()
        let level2_7 = SkipListNode(key: 7, data: "2-7", right: nil, down: nil)
        let level2_4 = SkipListNode(key: 4, data: "2-4", right: level2_7, down: nil)
        let level2_1 = SkipListNode(key: 1, data: "2-1", right: level2_4, down: nil)
        let level1_7 = SkipListNode(key: 7, data: "1-7", right: nil, down: level2_7)
        let level1_1 = SkipListNode(key: 1, data: "1-1", right: level1_7, down: level2_1)
        let skiplist = SkipList(head: level1_1, decisionMaker: decisionMaker)

        XCTAssertEqual(skiplist.head.key, 1)
        XCTAssertEqual(skiplist.head.right?.key, 7)
        XCTAssertEqual(skiplist.head.down?.key, 1)
        XCTAssertEqual(skiplist.head.down?.right?.key, 4)
        XCTAssertEqual(skiplist.head.down?.right?.right?.key, 7)

        // WHEN insert 3
        skiplist.insert(k: 3, data: "x-3")

        // THen become like this
        /// 1 -----------------------> 7
        /// ↓                               ↓
        /// 1 ----> 3 -----> 4 ----->7
        XCTAssertFalse(skiplist.decisionMaker.shouldInsert())
        XCTAssertEqual(skiplist.head.down?.right?.key, 3)
        XCTAssertEqual(skiplist.head.down?.right?.data as! String, "x-3")
        XCTAssertEqual(skiplist.head.down?.right?.right?.key, 4)
    }

    func testSkipListInsertWhenFlatIsTrue() {
        // GIVEN
        /// 1 -------------> 7
        /// ↓                   ↓
        /// 1 ----> 4 ----->7
        let decisionMaker = MockedDecisionMaker(insertFlag: true)
        let level2_7 = SkipListNode(key: 7, data: "2-7", right: nil, down: nil)
        let level2_4 = SkipListNode(key: 4, data: "2-4", right: level2_7, down: nil)
        let level2_1 = SkipListNode(key: 1, data: "2-1", right: level2_4, down: nil)
        let level1_7 = SkipListNode(key: 7, data: "1-7", right: nil, down: level2_7)
        let level1_1 = SkipListNode(key: 1, data: "1-1", right: level1_7, down: level2_1)
        let skiplist = SkipList(head: level1_1, decisionMaker: decisionMaker)

        XCTAssertEqual(skiplist.head.key, 1)
        XCTAssertEqual(skiplist.head.right?.key, 7)
        XCTAssertEqual(skiplist.head.down?.key, 1)
        XCTAssertEqual(skiplist.head.down?.right?.key, 4)
        XCTAssertEqual(skiplist.head.down?.right?.right?.key, 7)
        XCTAssertTrue(skiplist.decisionMaker.shouldInsert())

        // WHEN insert 3
        skiplist.insert(k: 3, data: "x-3")

        // THen become like this
        /// 1 ----> 3
        /// ↓        ↓
        /// 1 ----> 3 --------------> 7
        /// ↓        ↓                     ↓
        /// 1 ----> 3 -----> 4 ----->7
        XCTAssertTrue(skiplist.decisionMaker.shouldInsert())
        XCTAssertEqual(skiplist.head.right?.key, 3)
        XCTAssertEqual(skiplist.head.right?.data as! String, "x-3")
        XCTAssertEqual(skiplist.head.down?.key, 1)
        XCTAssertEqual(skiplist.head.down?.right?.key, 3)
        XCTAssertEqual(skiplist.head.down?.right?.right?.key, 7)
        XCTAssertEqual(skiplist.head.down?.down?.key, 1)
        XCTAssertEqual(skiplist.head.down?.down?.right?.key, 3)
        XCTAssertEqual(skiplist.head.down?.down?.right?.right?.key, 4)
        XCTAssertEqual(skiplist.head.down?.down?.right?.right?.right?.key, 7)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
