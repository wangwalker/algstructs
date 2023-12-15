//
//  SortTests.swift
//  
//
//  Created by Walker Wang on 2023/12/15.
//

import XCTest
@testable import Sort

final class SortTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSelectionSort() {
        let small = SelectionSort(items: smallItems)
        let big = SelectionSort(items: bigItems)
        small.sort()
        big.sort()
        XCTAssertEqual(small.items, sortedSmallItems)
        XCTAssertEqual(big.items, sortedBigItems)
    }

    func testInsertionSort() {
        let small = InsertionSort(items: smallItems)
        let big = InsertionSort(items: bigItems)
        small.sort()
        big.sort()
        XCTAssertEqual(small.items, sortedSmallItems)
        XCTAssertEqual(big.items, sortedBigItems)
    }

    func testShellSort() {
        let small = ShellSort(items: smallItems)
        let big = ShellSort(items: bigItems)
        small.sort()
        big.sort()
        XCTAssertEqual(small.items, sortedSmallItems)
        XCTAssertEqual(big.items, sortedBigItems)
    }

    func testQuickSort() {
        let small = QuickSort(items: smallItems)
        let big = QuickSort(items: bigItems)
        small.sort()
        big.sort()
        XCTAssertEqual(small.items, sortedSmallItems)
        XCTAssertEqual(big.items, sortedBigItems)
    }

    func testSimpleQuickSort() {
        let small = SimpleQuickSort(items: smallItems)
        let big = SimpleQuickSort(items: bigItems)
        small.sort()
        big.sort()
        XCTAssertEqual(small.items, sortedSmallItems)
        XCTAssertEqual(big.items, sortedBigItems)
    }

    func testMergeSort() {
        let small = MergeSort(items: smallItems)
        let big = MergeSort(items: bigItems)
        small.sort()
        big.sort()
        XCTAssertEqual(small.items, sortedSmallItems)
        XCTAssertEqual(big.items, sortedBigItems)
    }

    func randomItems(n: Int) -> [Int] {
        (0..<n).shuffled()
    }

    lazy var smallItems: [Int] = {
        randomItems(n: 10)
    }()
    lazy var bigItems: [Int] = {
        randomItems(n: 100)
    }()
    lazy var sortedSmallItems: [Int] = {
        smallItems.sorted()
    }()
    lazy var sortedBigItems: [Int] = {
        bigItems.sorted()
    }()

}
