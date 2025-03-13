//
//  MergeSort.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

/*
 MARK: - Problem: MergeSort Implementation with Different Approaches
 
 Implement MergeSort algorithm with both recursive (top-down) and iterative (bottom-up) approaches
 and visualize the sorting process.
 
 Example Input: [38, 27, 43, 3, 9, 82, 10]
 Expected Output: [3, 9, 10, 27, 38, 43, 82]
 
 ===================
 
 MARK: - Solution Approaches:
 
 Method 1: Top-Down (Recursive) MergeSort
 - Divides array recursively until single elements
 - Merges sorted subarrays back together
 - Time Complexity: O(n log n)
 
 Method 2: Bottom-Up (Iterative) MergeSort
 - Starts with single elements and merges upward
 - Avoids recursion overhead
 - Time Complexity: O(n log n)
 */

import SwiftUI

class MergeSorter {
    // MARK: - Method 1: Top-Down (Recursive) MergeSort
    static func topDownMergeSort(_ array: inout [Int]) -> [String] {
        var steps: [String] = []
        topDownSortHelper(&array, 0, array.count - 1, &steps)
        return steps
    }
    
    private static func topDownSortHelper(_ array: inout [Int], _ left: Int, _ right: Int, _ steps: inout [String]) {
        guard left < right else { return }
        
        let mid = (left + right) / 2
        steps.append("Dividing array[\(left)...\(right)]: \(array[left...right])")
        
        topDownSortHelper(&array, left, mid, &steps)
        topDownSortHelper(&array, mid + 1, right, &steps)
        
        merge(&array, left, mid, right, &steps)
    }
    
    // MARK: - Method 2: Bottom-Up (Iterative) MergeSort
    static func bottomUpMergeSort(_ array: inout [Int]) -> [String] {
        var steps: [String] = []
        let n = array.count
        
        // Iterate with increasing subarray size
        var width = 1
        while width < n {
            var left = 0
            
            // Merge subarrays of current width
            while left < n - width {
                let mid = left + width - 1
                let right = min(left + 2 * width - 1, n - 1)
                
                steps.append("Merging subarrays of width \(width): \(array[left...right])")
                merge(&array, left, mid, right, &steps)
                
                left += 2 * width
            }
            width *= 2
        }
        return steps
    }
    
    // Common merge function for both approaches
    private static func merge(_ array: inout [Int], _ left: Int, _ mid: Int, _ right: Int, _ steps: inout [String]) {
        let leftArray = Array(array[left...mid])
        let rightArray = Array(array[(mid + 1)...right])
        
        var i = 0, j = 0, k = left
        
        steps.append("Merging: Left=\(leftArray), Right=\(rightArray)")
        
        // Merge the two sorted subarrays
        while i < leftArray.count && j < rightArray.count {
            if leftArray[i] <= rightArray[j] {
                array[k] = leftArray[i]
                i += 1
            } else {
                array[k] = rightArray[j]
                j += 1
            }
            k += 1
        }
        
        // Copy remaining elements
        while i < leftArray.count {
            array[k] = leftArray[i]
            i += 1
            k += 1
        }
        
        while j < rightArray.count {
            array[k] = rightArray[j]
            j += 1
            k += 1
        }
        steps.append("After merge: \(array[left...right])")
    }
}

struct MergeSort: View {
    @State private var array1 = [38, 27, 43, 3, 9, 82, 10]
    @State private var array2 = [38, 27, 43, 3, 9, 82, 10]
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
                            array1 = [38, 27, 43, 3, 9, 82, 10]
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
                
                // Method 1: Top-Down MergeSort
                VStack(alignment: .leading) {
                    HStack {
                        Text("Method 1: Top-Down (Recursive) MergeSort")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    CustomButton(buttonName: "Sort (Top-Down)", buttonColor: .blue) {
                        sortingSteps1 = MergeSorter.topDownMergeSort(&array1)
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
                
                // Method 2: Bottom-Up MergeSort
                VStack(alignment: .leading) {
                    HStack {
                        Text("Method 2: Bottom-Up (Iterative) MergeSort")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    CustomButton(buttonName: "Sort (Bottom-Up)", buttonColor: .blue) {
                        sortingSteps2 = MergeSorter.bottomUpMergeSort(&array2)
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
        .navigationTitle("MergeSort")
    }
}

#Preview {
    MergeSort()
}
