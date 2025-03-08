//
//  Arrays Problem1.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

/*
 
 MARK: - Problem: Reverse an Array in Groups of Given Size
 
 Given an array and a group size `k`, reverse the elements in groups of `k`. If the remaining elements are less than `k`, reverse them as well.
 
 Example Input: let arr1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
 Expected Output: [3, 2, 1, 6, 5, 4, 9, 8, 7]
 
 ===================
 
 MARK: - Solution Approaches:
 
 Method 1: In-Place Reversal (Using `swapAt`)
 - This method modifies the original array in place by swapping elements to reverse each subarray of size `k`.
 - Most efficient in terms of both time and space complexity.
 
 Method 2: Functional Approach (Using `reversed()` and `flatMap`)
 - This method creates a new array by reversing subarrays of size `k` using Swift's functional programming features.
 - This approach is clean but slightly less efficient as it creates a new array.
 
 */

import SwiftUI

struct Arrays_Problem1: View {
    @State private var arr1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @State private var arr2 = [1, 2, 3, 4, 5, 6, 7, 8]
    @State private var arr3 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @State private var arr4 = [1, 2, 3, 4, 5, 6, 7, 8]
    
    @State private var k1 = 3
    @State private var k2 = 5
    @State private var k3 = 3
    @State private var k4 = 5
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Method 1: In-Place Reversal
                VStack(alignment: .leading) {
                    Text("Method 1: In-Place Reversal")
                        .font(.headline)
                    
                    VStack(alignment: .leading) {
                        Text("Array 1: [\(arr1.map { String($0) }.joined(separator: ", "))]")
                        Spacer()
                        Stepper("K: \(k1)", value: $k1, in: 1...arr1.count)
                    }//: VStack
                    
                    CustomButton(buttonName: "Reverse Array 1", buttonColor: Color.blue) {
                        reverseSubarraysInPlace(arr: &arr1, k: k1)
                    }
                    
                    Spacer(minLength: 30)
                    
                    VStack(alignment: .leading) {
                        Text("Array 2: [\(arr2.map { String($0) }.joined(separator: ", "))]")
                        Spacer()
                        Stepper("K: \(k2)", value: $k2, in: 1...arr2.count)
                    }//: VStack
                    
                    CustomButton(buttonName: "Reverse Array 2", buttonColor: Color.blue) {
                        reverseSubarraysInPlace(arr: &arr2, k: k2)
                    }
                }//: VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                // Method 2: Functional Approach
                VStack(alignment: .leading) {
                    Text("Method 2: Functional Approach")
                        .font(.headline)
                    
                    VStack(alignment: .leading) {
                        Text("Array 3: [\(arr3.map { String($0) }.joined(separator: ", "))]")
                        Spacer()
                        Stepper("K: \(k3)", value: $k3, in: 1...arr3.count)
                    }//: VStack
                    
                    CustomButton(buttonName: "Reverse Array 3", buttonColor: Color.blue) {
                        arr3 = reverseSubarraysFunctional(arr: arr3, k: k3)
                    }
                    
                    Spacer(minLength: 30)
                    
                    VStack(alignment: .leading) {
                        Text("Array 4: [\(arr4.map { String($0) }.joined(separator: ", "))]")
                        Spacer()
                        Stepper("K: \(k4)", value: $k4, in: 1...arr4.count)
                    }  //:VStack
                    
                    CustomButton(buttonName: "Reverse Array 4", buttonColor: Color.blue) {
                        arr4 = reverseSubarraysFunctional(arr: arr4, k: k4)
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
        .navigationTitle("Arrays Problem 1")
    }
    
    // MARK: - Method 1: In-Place Reversal (Most Efficient)
    func reverseSubarraysInPlace(arr: inout [Int], k: Int) {
        let n = arr.count
        var i = 0
        
        // Loop through the array in steps of size `k`
        while i < n {
            var left = i
            var right = min(i + k - 1, n - 1) // Ensure the right pointer doesn't exceed array bounds
            
            // Swap elements between the left and right pointers to reverse the subarray
            while left < right {
                arr.swapAt(left, right) // In-place swap
                left += 1
                right -= 1
            }
            
            i += k // Move to the next group of size `k`
        }
    }
    
    
    // MARK: - Method 2: Functional Approach (Using `reversed()` and `flatMap`)
    func reverseSubarraysFunctional(arr: [Int], k: Int) -> [Int] {
        let n = arr.count
        var result: [Int] = []
        
        // Loop through the array in steps of size `k`
        for i in stride(from: 0, to: n, by: k) {
            // Extract the subarray of size `k` (or smaller if at the end of the array)
            let subarray = Array(arr[i..<min(i + k, n)])
            
            // Reverse the subarray and append it to the result
            result.append(contentsOf: subarray.reversed())
        }
        
        return result
    }
    
}

#Preview {
    Arrays_Problem1()
}
