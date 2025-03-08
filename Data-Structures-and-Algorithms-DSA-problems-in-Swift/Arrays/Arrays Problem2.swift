//
//  Arrays Problem2.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

/*
MARK: - Problem: Rotate an Array by d (Counterclockwise or Left)

Given an array and an integer `d`, rotate the array to the left by `d` positions.
If `d` is greater than the array size, it should wrap around. For negative `d`, no rotation is performed.

Example Input 1: let arr1 = [1, 2, 3, 4, 5, 6], d = 2
Expected Output: [3, 4, 5, 6, 1, 2]

Example Input 2: let arr2 = [1, 2, 3], d = 4
Expected Output: [2, 3, 1]

Example Input 3: let arr6 = [1, 2, 3], d = -1
Expected Output: [1, 2, 3] (No rotation for negative `d`)

===================

MARK: - Solution Approaches:

Method 1: Using Array Slicing and Concatenation (Simplest)
    - This method utilizes Swift's array slicing and concatenation to perform rotation in an easy-to-understand way.
    - Handles cases where `d > n` by performing modulo operation.

Method 2: In-Place Rotation (Using Reversal Algorithm)
    - This method rotates the array in place using the reversal algorithm, which is space-efficient (O(1) space).
    - The most efficient approach for space optimization.
*/

import SwiftUI

struct Arrays_Problem2: View {
    @State private var arr1 = [1, 2, 3, 4, 5, 6]
    @State private var arr2 = [1, 2, 3]
    @State private var arr3 = [1, 2, 3]
    @State private var arr11 = [1, 2, 3, 4, 5, 6]
    @State private var arr12 = [1, 2, 3]
    @State private var arr13 = [1, 2, 3]
    
    @State private var d1 = 2
    @State private var d2 = 4
    @State private var d3 = -1
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Method 1: Using Array Slicing and Concatenation
                VStack(alignment: .leading) {
                    Text("Method 1: Using Array Slicing and Concatenation")
                        .font(.headline)
                    
                    VStack(alignment: .leading) {
                        Text("Array 1: [\(arr1.map { String($0) }.joined(separator: ", "))]")
                        Spacer()
                        Stepper("D: \(d1)", value: $d1, in: 1...arr1.count)
                    }//: VStack
                    
                    CustomButton(buttonName: "Rotate Array 1", buttonColor: Color.blue) {
                        arr1 = rotateLeftUsingSlicing(arr: arr1, d: d1)
                        print(arr1) // Output: [3, 4, 5, 6, 1, 2]
                    }
                    
                    Spacer(minLength: 30)
                    
                    VStack(alignment: .leading) {
                        Text("Array 2: [\(arr2.map { String($0) }.joined(separator: ", "))]")
                        Spacer()
                        Stepper("D: \(d2)", value: $d2, in: 1...arr2.count)
                    }//: VStack
                    
                    CustomButton(buttonName: "Rotate Array 2", buttonColor: Color.blue) {
                        arr2 = rotateLeftUsingSlicing(arr: arr2, d: d2)
                        print(arr2) // Output: [2, 3, 1]
                    }
                    
                    Spacer(minLength: 30)
                    
                    VStack(alignment: .leading) {
                        Text("Array 3: [\(arr3.map { String($0) }.joined(separator: ", "))] (No rotation for negative `d`)")
                        Spacer()
                        Stepper("D: \(d3)", value: $d3, in: -10...arr3.count)
                    }//: VStack
                    
                    CustomButton(buttonName: "Rotate Array 3", buttonColor: Color.blue) {
                        arr3 = rotateLeftUsingSlicing(arr: arr3, d: d3)
                        print(arr3) // Output: [1, 2, 3] (No rotation for negative `d`)
                    }
                }//: VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                // Method 2: In-Place Rotation
                VStack(alignment: .leading) {
                    Text("Method 2: In-Place Rotation")
                        .font(.headline)
                    
                    VStack(alignment: .leading) {
                        Text("Array 11: [\(arr11.map { String($0) }.joined(separator: ", "))]")
                        Spacer()
                        Stepper("D: \(d1)", value: $d1, in: 1...arr11.count)
                    }//: VStack
                    
                    CustomButton(buttonName: "Rotate Array 11", buttonColor: Color.blue) {
                        rotateLeftInPlace(arr: &arr11, d: d1)
                        print(arr11) // Output: [3, 4, 5, 6, 1, 2]
                    }
                    
                    Spacer(minLength: 30)
                    
                    VStack(alignment: .leading) {
                        Text("Array 12: [\(arr12.map { String($0) }.joined(separator: ", "))]")
                        Spacer()
                        Stepper("D: \(d2)", value: $d2, in: 1...arr12.count)
                    }  //:VStack
                    
                    CustomButton(buttonName: "Rotate Array 12", buttonColor: Color.blue) {
                        rotateLeftInPlace(arr: &arr12, d: d2)
                        print(arr12) // Output: [2, 3, 1]
                    }
                    
                    Spacer(minLength: 30)
                    
                    VStack(alignment: .leading) {
                        Text("Array 13: [\(arr13.map { String($0) }.joined(separator: ", "))] (No rotation for negative `d`)")
                        Spacer()
                        Stepper("D: \(d3)", value: $d3, in: -10...arr13.count)
                    }  //:VStack
                    
                    CustomButton(buttonName: "Rotate Array 13", buttonColor: Color.blue) {
                        rotateLeftInPlace(arr: &arr13, d: d3)
                        print(arr13) // Output: [1, 2, 3] (No rotation for negative `d`)
                    }
                }  //:VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            } //:VStack
            .padding()
        }//: ScrollView
        .navigationTitle("Arrays Problem 2")
    }
    
    // MARK: - Method 1: Using Array Slicing and Concatenation (Simplest)
    func rotateLeftUsingSlicing(arr: [Int], d: Int) -> [Int] {
        let n = arr.count
        let effectiveRotations = d % n // Handle cases where d > n

        // If rotations are negative or if the array is empty, return the original array
        guard effectiveRotations >= 0 else {
            print("Rotations cannot be negative")
            return arr
        }
        
        if n == 0 {
            return []
        }

        // Slice the array and concatenate the two parts, then convert the result to an array
        let rotatedArray = Array(arr[effectiveRotations..<n] + arr[0..<effectiveRotations])
        return rotatedArray
    }
    
    // MARK: - Method 2: In-Place Rotation (Using Reversal Algorithm)
    func rotateLeftInPlace(arr: inout [Int], d: Int) {
        let n = arr.count
        let effectiveRotations = d % n // Handle cases where `d > n`

        // If rotations are negative or if the array is empty, return without modification
        guard effectiveRotations >= 0 else {
            print("Rotations cannot be negative")
            return
        }
        
        if n == 0 {
            return
        }

        // Step 1: Reverse the first 'd' elements
        reverseArray(&arr, start: 0, end: effectiveRotations - 1)

        // Step 2: Reverse the remaining 'n - d' elements
        reverseArray(&arr, start: effectiveRotations, end: n - 1)

        // Step 3: Reverse the entire array to complete the rotation
        reverseArray(&arr, start: 0, end: n - 1)
    }

    // Helper function to reverse a portion of the array
    private func reverseArray(_ arr: inout [Int], start: Int, end: Int) {
        var start = start
        var end = end
        while start < end {
            arr.swapAt(start, end)
            start += 1
            end -= 1
        }
    }
}

#Preview {
    Arrays_Problem2()
}
