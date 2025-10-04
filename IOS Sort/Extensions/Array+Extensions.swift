//
//  Array+Extensions.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import Foundation

extension Array where Element: Comparable {
    /// Shuffles the array in place using Fisher-Yates algorithm
    mutating func shuffle() {
        for i in stride(from: count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            swapAt(i, j)
        }
    }
    
    /// Returns a shuffled copy of the array
    func shuffled() -> [Element] {
        var array = self
        array.shuffle()
        return array
    }
    
    /// Checks if the array is sorted in ascending order
    var isSorted: Bool {
        for i in 1..<count {
            if self[i] < self[i-1] {
                return false
            }
        }
        return true
    }
}

extension Array {
    /// Swaps elements at the given indices
    mutating func swapAt(_ i: Int, _ j: Int) {
        guard i != j else { return }
        let temp = self[i]
        self[i] = self[j]
        self[j] = temp
    }
}
