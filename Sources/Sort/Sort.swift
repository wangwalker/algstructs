//
//  File.swift
//  
//
//  Created by Walker Wang on 2023/12/14.
//

import Foundation

public protocol Sortable {
    func sort()
}

public protocol Swappable {
    func swap(_ i: Int, _ j: Int)
}

public protocol Logable {
    func log()
}

public class Sort<T>: Sortable, Swappable, Logable where T: Comparable & CustomStringConvertible {
    public var items: [T]
    var swappingCount: Int = 0

    public init(items: [T]) {
        self.items = items
    }
    public func sort() { }
    public func swap(_ i: Int, _ j: Int) {
        items.swapAt(i, j)
        swappingCount += 1
    }
    public func log() {
        print(
                """
                \nSort log:\n
                swapping count = \(swappingCount)\n
                sorted: \(items)
                """
        )
    }
}
extension Sort {
    public var description: String {
        get {
            "[" + items.map { $0.description } .joined(separator: ", ") + "]"
        }
    }
}

public class SelectionSort: Sort<Int> {
    public override func sort() {
        for outer in 0..<items.count {
            var minIndex = outer
            var min = items[outer]

            for inner in outer+1..<items.count {
                if min > items[inner] {
                    minIndex = inner
                    min = items[inner]
                }
            }
            if outer != minIndex {
                swap(outer, minIndex)
            }
        }
        log()
    }
}

public class InsertionSort: Sort<Int> {
    public override func sort() {
        for outer in 1..<super.items.count {
            let current = items[outer];
            for inner in 0..<outer {
                if items[inner] > current {
                    swap(outer, inner)
                }
            }
        }
        log()
    }
}

/// 泛化的插入排序
/// 在插入排序中，比较的幅度为1；在希尔排序中，比较的幅度从大概n/3，一直降到1
public class ShellSort: Sort<Int> {
    public override func sort() {
        let n = items.count
        var step = 1
        while step <= n/3 {
            step = 3*step + 1
        }
        while step >= 1 {
            for i in step..<n {
                for j in stride(from: i, through: 0, by: -step) {
                    if j >= step && items[j] < items[j-step] {
                        swap(j, j-step)
                    }
                }
            }
            step = step/3
        }
        log()
    }
}

/// 易于理解的快速排序
/// 用第一个或随机元素作为切分点，比它大的、小的都放入新数组中，最后递归构造一个新的数组
public class SimpleQuickSort: Sort<Int> {
    public override func sort() {
        let sorted = sort(items)
        items = sorted
    }
    private func sort(_ elements: [Int]) -> [Int] {
        if elements.count < 2 {
            return elements
        }
        let partion = first(elements)

        var less: [Int] = []
        var more: [Int] = []
        var same: [Int] = [partion]
        for element in elements.suffix(elements.count-1) {
            if element < partion {
                less.append(element)
            } else if element > partion {
                more.append(element)
            } else {
                same.append(element)
            }
        }
        return sort(less) + same + sort(more)
    }
    private func first(_ elements: [Int]) -> Int {
        elements[0]
    }
}

/// 快速排序
/// 快速排序也是分而治之的思想，每次至少能将一个元素放在合适的位置，时间复杂度是O(n*log(n))
/// 快速排序虽然很快，但非常脆弱，如果元素很少或者有序性较好，可能退回O(n*n)
public class QuickSort: Sort<Int> {
    public override func sort() {
        sort(lo: 0, hi: items.count-1)
        log()
    }
    private func sort(lo: Int, hi: Int) {
        if hi <= lo {
            return
        }
        let j = partion(lo: lo, hi: hi)
        sort(lo: lo, hi: j-1)
        sort(lo: j+1, hi: hi)
    }
    private func partion(lo: Int, hi: Int) -> Int {
        var i = lo
        var j = hi + 1  // 第一个元素作为切分点，后面的比较过程会将其越过，但最后一个元素不能被越过，所以j向后挪了一位
        let v = items[i]
        while true {
            /// left <= v
            i += 1
            j -= 1
            while i < items.count && items[i] <= v {
                if i == hi {
                    break
                }
                i += 1
            }
            /// v <= right
            while v <= items[j] {
                if j == lo {
                    break
                }
                j -= 1
            }
            if i >= j {
                break
            }
            swap(i, j)
        }
        swap(lo, j)
        return j
    }
}

/// 归并排序
/// 其思想也是分而治之，先将数组分成两半，分别排好序，然后再将这两半合并在一起
/// 除此之外，还需要额外的存储空间
public class MergeSort: Sort<Int> {
    private var aux: [Int] = []
    private var recursiveCount = 0
    public override func sort() {
        aux = Array.init(repeating: 0, count: items.count)
        sort(lo: 0, hi: items.count-1)
        print("recursive count is \(recursiveCount)")
    }
    private func sort(lo: Int, hi: Int) {
//        if lo >= hi {
//            return
//        }
        /// 当子数组长度小于3时，直接用插入排序
        if hi - lo <= 3 {
            /// 至少有两个元素
            if hi - lo >= 1  {
                for i in (lo+1)...hi {
                    for j in lo..<i {
                        if items[j] > items[i] {
                            swap(i, j)
                        }
                    }
                }
            }
            return
        }
        recursiveCount += 1
        let mid = (lo + hi) / 2
        sort(lo: lo, hi: mid)
        sort(lo: mid+1, hi: hi)
        merge(lo: lo, mi: mid, hi: hi)
    }
    private func merge(lo: Int, mi: Int, hi: Int) {
        var i = lo      /// 左半部分的开始
        var j = mi + 1  /// 右半部分的开始
        for k in lo...hi {
            aux[k] = items[k]
        }
        for k in lo...hi {
            /// 如果左边用完，取右边的部分
            if i > mi {
                items[k] = aux[j]
                j += 1
            }
            /// 如果右半部分用完，取左半部分的
            else if j > hi {
                items[k] = aux[i]
                i += 1
            }
            /// 如果右半部分小于左半部分，取右半部分的
            else if aux[j] < aux[i] {
                items[k] = aux[j]
                j += 1
            }
            /// 否则，左半部分更小，取左半部分的
            else {
                items[k] = aux[i]
                i += 1
            }
        }
    }
}
