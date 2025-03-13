//
//  QuickSort.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

/*
 MARK: - Problem: QuickSort Implementation with Different Pivot Strategies
 
 Implement QuickSort algorithm with different pivot selection strategies and visualize the sorting process.
 
 Example Input: [64, 34, 25, 12, 22, 11, 90]
 Expected Output: [11, 12, 22, 25, 34, 64, 90]
 
 ===================
 
 MARK: - Solution Approaches:
 
 Method 1: First Element as Pivot
 - Simple but can be inefficient for sorted or nearly sorted arrays
 - Time Complexity: Average O(n log n), Worst O(n²)
 
 Method 2: Random Element as Pivot
 - Better performance for most cases
 - Helps avoid worst-case scenarios
 - Time Complexity: Average O(n log n)
 */

import SwiftUI

class QuickSorter {
    enum PivotStrategy {
        case first
        case random
    }
    
    // MARK: - Method 1: First Element as Pivot
    static func quickSortFirst(_ array: inout [Int], low: Int, high: Int) -> [String] {
        var steps: [String] = []
        quickSortFirstHelper(&array, low: low, high: high, steps: &steps)
        return steps
    }
    
    private static func quickSortFirstHelper(_ array: inout [Int], low: Int, high: Int, steps: inout [String]) {
        if low < high {
            steps.append("Partitioning array[\(low)...\(high)]: \(array)")
            
            let pivotIndex = partitionFirst(&array, low: low, high: high)
            steps.append("After partition (pivot=\(array[pivotIndex])): \(array)")
            
            quickSortFirstHelper(&array, low: low, high: pivotIndex - 1, steps: &steps)
            quickSortFirstHelper(&array, low: pivotIndex + 1, high: high, steps: &steps)
        }
    }
    
    private static func partitionFirst(_ array: inout [Int], low: Int, high: Int) -> Int {
        let pivot = array[low]
        var i = high + 1
        
        for j in stride(from: high, through: low + 1, by: -1) {
            if array[j] > pivot {
                i -= 1
                array.swapAt(i, j)
            }
        }
        array.swapAt(i - 1, low)
        return i - 1
    }
    
    // MARK: - Method 2: Random Element as Pivot
    static func quickSortRandom(_ array: inout [Int], low: Int, high: Int) -> [String] {
        var steps: [String] = []
        quickSortRandomHelper(&array, low: low, high: high, steps: &steps)
        return steps
    }
    
    private static func quickSortRandomHelper(_ array: inout [Int], low: Int, high: Int, steps: inout [String]) {
        if low < high {
            steps.append("Partitioning array[\(low)...\(high)]: \(array)")
            
            // Choose random pivot and swap with first element
            let randomPivot = Int.random(in: low...high)
            array.swapAt(low, randomPivot)
            
            let pivotIndex = partitionFirst(&array, low: low, high: high)
            steps.append("After partition (pivot=\(array[pivotIndex])): \(array)")
            
            quickSortRandomHelper(&array, low: low, high: pivotIndex - 1, steps: &steps)
            quickSortRandomHelper(&array, low: pivotIndex + 1, high: high, steps: &steps)
        }
    }
}

struct QuickSort: View {
    @State private var array1 = [64, 34, 25, 12, 22, 11, 90]
    @State private var array2 = [64, 34, 25, 12, 22, 11, 90]
    @State private var sortingSteps1: [String] = []
    @State private var sortingSteps2: [String] = []
    @State private var newNumber: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Array Input Section
                VStack(alignment: .leading) {
                    Text("Input Array")
                        .font(.headline)
                    
                    HStack {
                        CustomTextField(placeHolderText: "Enter number", color: .gray, value: $newNumber)
                            .keyboardType(.numberPad)
                        
                        CustomButton(buttonName: "Add", buttonColor: .blue) {
                            if let number = Int(newNumber) {
                                array1.append(number)
                                array2 = array1
                                newNumber = ""
                            }
                        }
                        .disabled(newNumber.isEmpty)
                        
                        CustomButton(buttonName: "Reset", buttonColor: .red) {
                            array1 = [64, 34, 25, 12, 22, 11, 90]
                            array2 = array1
                            sortingSteps1 = []
                            sortingSteps2 = []
                        }
                    }//: HStack
                    
                    Text("Current Array: \(array1.map { String($0) }.joined(separator: ", "))")
                        .padding(.vertical)
                }//: VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                // Method 1: First Element as Pivot
                VStack(alignment: .leading) {
                    HStack {
                        Text("Method 1: First Element as Pivot")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    CustomButton(buttonName: "Sort (First Pivot)", buttonColor: .blue) {
                        sortingSteps1 = QuickSorter.quickSortFirst(&array1, low: 0, high: array1.count - 1)
                    }
                    
                    if !sortingSteps1.isEmpty {
                        Text("Sorting Steps:")
                            .font(.subheadline)
                            .padding(.top)
                        
                        ForEach(sortingSteps1.indices, id: \.self) { index in
                            Text("\(index + 1). \(sortingSteps1[index])")
                                .font(.caption)
                        }//: ForEach
                        
                        Text("Final Result: \(array1.map { String($0) }.joined(separator: ", "))")
                            .padding(.top)
                    }
                }//: VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                // Method 2: Random Element as Pivot
                VStack(alignment: .leading) {
                    HStack {
                        Text("Method 2: Random Element as Pivot")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    CustomButton(buttonName: "Sort (Random Pivot)", buttonColor: .blue) {
                        sortingSteps2 = QuickSorter.quickSortRandom(&array2, low: 0, high: array2.count - 1)
                    }
                    
                    if !sortingSteps2.isEmpty {
                        Text("Sorting Steps:")
                            .font(.subheadline)
                            .padding(.top)
                        
                        ForEach(sortingSteps2.indices, id: \.self) { index in
                            Text("\(index + 1). \(sortingSteps2[index])")
                                .font(.caption)
                        }//: ForEach
                        
                        Text("Final Result: \(array2.map { String($0) }.joined(separator: ", "))")
                            .padding(.top)
                    }
                }//: VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }//: VStack
            .padding()
        }//: ScrollView
        .navigationTitle("QuickSort")
    }
}

#Preview {
    QuickSort()
}
