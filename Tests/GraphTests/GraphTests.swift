//
//  GraphTests.swift
//  
//
//  Created by Walker Wang on 2023/12/17.
//

import XCTest
@testable import Graph

final class GraphTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGraphCreate() {
        let g = BasicGraph(v: 10)
        XCTAssertEqual(g.vertices, 10)
        XCTAssertEqual(g.edges, 0)
        XCTAssertEqual(g.adjacents(v: 0), [])
        g.addEdge(v: 0, w: 1, wt: 0)
        g.addEdge(v: 0, w: 2, wt: 0)
        XCTAssertEqual(g.edges, 2)
        XCTAssertEqual(g.adjacents(v: 0), [1, 2])

        let adj0 = [1, 2, 3]
        let adj1 = [0, 2]
        let adj2 = [0, 1]
        let adj3 = [0, 4]
        let adj4 = [3]
        XCTAssertEqual(g1.vertices, 5)
        XCTAssertEqual(g1.edges, 5)
        XCTAssertEqual(g1.adjacents(v: 0), adj0)
        XCTAssertEqual(g1.adjacents(v: 1), adj1)
        XCTAssertEqual(g1.adjacents(v: 2), adj2)
        XCTAssertEqual(g1.adjacents(v: 3), adj3)
        XCTAssertEqual(g1.adjacents(v: 4), adj4)
    }

    func testBasicGraphDFS() {
        let dfs = DepthFirstSearch(g: g1)
        dfs.search(s: 0)

        XCTAssertEqual(dfs.path(to: 2), [2, 1, 0])
        XCTAssertEqual(dfs.path(to: 4), [4, 3, 0])
        for i in 0..<g1.vertices-1 {
            XCTAssertTrue(dfs.marked(v: i))
        }
    }

    func testConnctedComponents() {
        let cc = ConnectedComponent(graph: g2)
        XCTAssertTrue(cc.connected(vertices: [0, 1, 2]))
        XCTAssertTrue(cc.connected(vertices: [0, 1, 1, 6]))
        XCTAssertEqual(cc.connected(vertices: [0, 1, 9]), false)
    }

    func testGraphCycle() {
        let cycle = CycleFinder(g: g3)
        XCTAssertTrue(cycle.hasCycle())
        XCTAssertGreaterThanOrEqual(cycle.cycle(start: 0).count, 3)
        XCTAssertEqual(cycle.cycle(start: 0), [2, 1, 0, 2])
    }

    func testGraphBFS() {
        let bfs = BreadthFirstSearch(g: g2)
        bfs.search(s: 0)
        XCTAssertEqual(bfs.path(to: 1), [1, 0])
        XCTAssertEqual(bfs.path(to: 2), [2, 0])
        XCTAssertEqual(bfs.path(to: 6), [6, 1, 0])
        XCTAssertEqual(bfs.path(to: 3), [3, 0])
        XCTAssertEqual(bfs.path(to: 4), [4, 3, 0])
        XCTAssertEqual(bfs.path(to: 8), [8, 2, 0])
        for i in 0..<g2.vertices-1 {
            if i < 9 {
                XCTAssertTrue(bfs.marked(v: i))
            } else {
                XCTAssertFalse(bfs.marked(v: i))
            }
        }
    }

    func testShortestPath() {
        XCTAssertEqual(g4.edges, 5)

        let sp1 = ShortestPath(g: g4, s: 0)
        XCTAssertEqual(sp1.distance(to: 3), 6)
        XCTAssertEqual(sp1.path(to: 3), [3, 1, 2, 0])

        let sp2 = ShortestPath(g: g5, s: 0)
        XCTAssertEqual(sp2.distance(to: 5), 8)
        XCTAssertEqual(sp2.path(to: 5), [5, 3, 1, 0])
    }

    lazy var g1: BasicGraph = {
        let adj0 = [1, 2, 3]
        let adj1 = [0, 2]
        let adj2 = [0, 1]
        let adj3 = [0, 4]
        let adj4 = [3]
        let g = BasicGraph(v: 5, adj: [adj0, adj1, adj2, adj3, adj4])
        return g
    }()
    lazy var g2: BasicGraph = {
        let adj0 = [1, 2, 3]
        let adj1 = [0, 2, 6]
        let adj2 = [0, 1, 6, 8]
        let adj3 = [0, 4, 5, 7]
        let adj4 = [3, 8]
        let adj5 = [3]
        let adj6 = [1, 2]
        let adj7 = [3]
        let adj8 = [2, 4]
        let adj9 = [10, 11]
        let adj10 = [9]
        let adj11 = [9]
        let g = BasicGraph(v:12, adj: [adj0, adj1, adj2, adj3, adj4, adj5, adj6, adj7, adj8, adj9, adj10, adj11])
        return g
    }()
    lazy var g3: DirectedGraph = {
        let adj0 = [1, 3]
        let adj1 = [2, 6]
        let adj2 = [0, 6]
        let adj3 = [5, 7]
        let adj4 = [3]
        let adj5: [Int] = []
        let adj6: [Int] = []
        let adj7: [Int] = []
        let adj8 = [4]
        let adj9 = [10, 11]
        let adj10: [Int] = []
        let adj11: [Int] = []
        let g = DirectedGraph(v:12, adj: [adj0, adj1, adj2, adj3, adj4, adj5, adj6, adj7, adj8, adj9, adj10, adj11])
        return g
    }()
    lazy var g4: EdgeWeigtedDiGraph = {
        let g = EdgeWeigtedDiGraph(v: 4)
        g.addEdge(v: 0, w: 1, wt: 6)
        g.addEdge(v: 0, w: 2, wt: 2)
        g.addEdge(v: 1, w: 3, wt: 1)
        g.addEdge(v: 2, w: 1, wt: 3)
        g.addEdge(v: 2, w: 3, wt: 5)
        return g
    }()
    lazy var g5: EdgeWeigtedDiGraph = {
        let g = EdgeWeigtedDiGraph(v: 6)
        g.addEdge(v: 0, w: 1, wt: 5)
        g.addEdge(v: 0, w: 2, wt: 2)
        g.addEdge(v: 1, w: 3, wt: 2)
        g.addEdge(v: 1, w: 4, wt: 4)
        g.addEdge(v: 2, w: 1, wt: 8)
        g.addEdge(v: 2, w: 3, wt: 7)
        g.addEdge(v: 3, w: 5, wt: 1)
        g.addEdge(v: 4, w: 3, wt: 6)
        g.addEdge(v: 4, w: 5, wt: 3)
        return g
    }()

}
