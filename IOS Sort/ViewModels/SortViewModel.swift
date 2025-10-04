//
//  SortViewModel.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import Foundation
import SwiftUI

@MainActor
class SortViewModel: ObservableObject {
    @Published var numbers: [Int] = []
    @Published var isSorting = false
    @Published var sortAlgorithm: SortAlgorithm = .bubbleSort
    
    enum SortAlgorithm: String, CaseIterable {
        case bubbleSort = "Bubble Sort"
        case quickSort = "Quick Sort"
        case mergeSort = "Merge Sort"
        case selectionSort = "Selection Sort"
    }
    
    func generateRandomNumbers(count: Int = 20) {
        numbers = (1...count).map { _ in Int.random(in: 1...100) }
    }
    
    func sortNumbers() async {
        isSorting = true
        
        switch sortAlgorithm {
        case .bubbleSort:
            await bubbleSort()
        case .quickSort:
            await quickSort()
        case .mergeSort:
            await mergeSort()
        case .selectionSort:
            await selectionSort()
        }
        
        isSorting = false
    }
    
    private func bubbleSort() async {
        var array = numbers
        let n = array.count
        
        for i in 0..<n {
            for j in 0..<(n - i - 1) {
                if array[j] > array[j + 1] {
                    array.swapAt(j, j + 1)
                    await MainActor.run {
                        numbers = array
                    }
                    try? await Task.sleep(nanoseconds: 50_000_000) // 50ms delay for visualization
                }
            }
        }
    }
    
    private func quickSort() async {
        numbers = await quickSortHelper(numbers)
    }
    
    private func quickSortHelper(_ array: [Int]) async -> [Int] {
        guard array.count > 1 else { return array }
        
        let pivot = array[array.count / 2]
        let less = array.filter { $0 < pivot }
        let equal = array.filter { $0 == pivot }
        let greater = array.filter { $0 > pivot }
        
        let sortedLess = await quickSortHelper(less)
        let sortedGreater = await quickSortHelper(greater)
        
        let result = sortedLess + equal + sortedGreater
        
        await MainActor.run {
            numbers = result
        }
        
        try? await Task.sleep(nanoseconds: 100_000_000) // 100ms delay
        
        return result
    }
    
    private func mergeSort() async {
        numbers = await mergeSortHelper(numbers)
    }
    
    private func mergeSortHelper(_ array: [Int]) async -> [Int] {
        guard array.count > 1 else { return array }
        
        let mid = array.count / 2
        let left = Array(array[0..<mid])
        let right = Array(array[mid..<array.count])
        
        let sortedLeft = await mergeSortHelper(left)
        let sortedRight = await mergeSortHelper(right)
        
        return await merge(sortedLeft, sortedRight)
    }
    
    private func merge(_ left: [Int], _ right: [Int]) async -> [Int] {
        var result: [Int] = []
        var leftIndex = 0
        var rightIndex = 0
        
        while leftIndex < left.count && rightIndex < right.count {
            if left[leftIndex] <= right[rightIndex] {
                result.append(left[leftIndex])
                leftIndex += 1
            } else {
                result.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        result.append(contentsOf: left[leftIndex...])
        result.append(contentsOf: right[rightIndex...])
        
        await MainActor.run {
            numbers = result
        }
        
        try? await Task.sleep(nanoseconds: 50_000_000) // 50ms delay
        
        return result
    }
    
    private func selectionSort() async {
        var array = numbers
        
        for i in 0..<array.count {
            var minIndex = i
            
            for j in (i + 1)..<array.count {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            
            if minIndex != i {
                array.swapAt(i, minIndex)
                await MainActor.run {
                    numbers = array
                }
                try? await Task.sleep(nanoseconds: 100_000_000) // 100ms delay
            }
        }
    }
}
