//
//  File.swift
//  
//
//  Created by Walker Wang on 2023/12/14.
//

import Foundation

extension Array {
    // Search index of one item with binary searching algorthim
    public mutating func binaryIndex(of data: Element) -> Int? where Element: Comparable {
        let sortedSelf = self.sorted(by: { $0 < $1})
        var low = 0, high = self.count - 1
        let mid = (low + high) / 2
        self = sortedSelf

        while (low < high) {
            let guess = sortedSelf[mid]
            if (guess == data) {
                return mid
            }
            if (guess < data) {
                low = mid + 1
            } else if (guess > data) {
                high = mid - 1
            }
        }
        return nil
    }
}
