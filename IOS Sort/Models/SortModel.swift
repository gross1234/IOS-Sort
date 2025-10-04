//
//  SortModel.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import Foundation

struct SortModel {
    let algorithm: SortAlgorithm
    let timeComplexity: String
    let spaceComplexity: String
    let description: String
    
    enum SortAlgorithm: String, CaseIterable {
        case bubbleSort = "Bubble Sort"
        case quickSort = "Quick Sort"
        case mergeSort = "Merge Sort"
        case selectionSort = "Selection Sort"
        
        var details: SortModel {
            switch self {
            case .bubbleSort:
                return SortModel(
                    algorithm: self,
                    timeComplexity: "O(n²)",
                    spaceComplexity: "O(1)",
                    description: "Simple sorting algorithm that repeatedly steps through the list, compares adjacent elements and swaps them if they are in the wrong order."
                )
            case .quickSort:
                return SortModel(
                    algorithm: self,
                    timeComplexity: "O(n log n)",
                    spaceComplexity: "O(log n)",
                    description: "Efficient divide-and-conquer algorithm that picks a 'pivot' element and partitions the array around it."
                )
            case .mergeSort:
                return SortModel(
                    algorithm: self,
                    timeComplexity: "O(n log n)",
                    spaceComplexity: "O(n)",
                    description: "Stable divide-and-conquer algorithm that divides the array into halves, sorts them, and merges them back together."
                )
            case .selectionSort:
                return SortModel(
                    algorithm: self,
                    timeComplexity: "O(n²)",
                    spaceComplexity: "O(1)",
                    description: "Simple algorithm that finds the minimum element and swaps it with the first element, repeating for the remaining elements."
                )
            }
        }
    }
}
