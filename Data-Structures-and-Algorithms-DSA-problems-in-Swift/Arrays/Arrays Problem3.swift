//
//  Arrays Problem3.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

/*
 
MARK: - Question : Second Largest Element in an Array

 Input : let numbersArr = [12, 38, 15, 10, 45, 18, 38, 6, 7, 9]
 Expected Output : 38

===================
 
MARK: - Answer Explanation:
 
 Method 1 (Sorting): The array is sorted in descending order, and the function returns the second unique element that is not equal to the largest.
 
 Method 2 (Set): The array is converted to a set to remove duplicates, sorted in descending order, and the second element is returned.

*/

import SwiftUI

struct Arrays_Problem3: View {
    @State private var numbersArrayForMethod1 = [12, 38, 15, 10, 45, 38, 6]
    @State private var numbersArrayForMethod2 = [13, 38, 15, 45, 18, 38, 60, 9]
    @State private var newNumberForMethod1Array: String = ""
    @State private var newNumberForMethod2Array: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Method 1: Using Sorting
                VStack(alignment: .leading, spacing: 10) {
                    Text("Method 1: Using Sorting")
                        .font(.headline)
                    
                    VStack(alignment: .leading) {
                        Text("Array 1: [\(numbersArrayForMethod1.map { String($0) }.joined(separator: ", "))]")
                        HStack {
                            CustomTextField(placeHolderText: "input new number", color:.gray, value: $newNumberForMethod1Array)
                            Spacer()
                            CustomButton(buttonName: "+  ", buttonColor: Color.blue) {
                                numbersArrayForMethod1.append(Int(newNumberForMethod1Array) ?? 0)
                                newNumberForMethod1Array = ""
                            }.disabled(newNumberForMethod1Array == "" ? true : false)
                        }//: HStack
                    }//: VStack
                    
                    // Usage of Method 1
                    if let secondLargestNumber = findSecondLargestUsingSorting(in: numbersArrayForMethod1) {
                        Text("Output (Sorting): \(secondLargestNumber)")
                    } else {
                        Text("Output (Sorting): No second largest element")
                    }
                    
                }//: VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                // Method 2: Using Set
                VStack(alignment: .leading, spacing: 10) {
                    Text("Method 2: Using Set")
                        .font(.headline)
                    
                    VStack(alignment: .leading) {
                        Text("Array 2: [\(numbersArrayForMethod2.map { String($0) }.joined(separator: ", "))]")
                        HStack {
                            CustomTextField(placeHolderText: "input new number", color: .gray, value: $newNumberForMethod2Array)
                            Spacer()
                            CustomButton(buttonName: "+  ", buttonColor: Color.blue) {
                                numbersArrayForMethod2.append(Int(newNumberForMethod2Array) ?? 0)
                                newNumberForMethod2Array = ""
                            }.disabled(newNumberForMethod2Array == "" ? true : false)
                        }//: HStack
                    }//: VStack
                    
                    // Usage of Method 2
                    if let secondLargestNumberr = findSecondLargestUsingSet(in: numbersArrayForMethod2) {
                        Text("Output (Set): \(secondLargestNumberr)")
                    } else {
                        Text("Output (Set): No second largest element")
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
        .navigationTitle("Arrays Problem 3")
    }
    
    // MARK: - Method 1: Using Sorting
    func findSecondLargestUsingSorting(in array: [Int]) -> Int? {
        guard array.count >= 2 else {
            return nil // Array too small
        }
        
        let sortedArray = array.sorted(by: >) // Sort in descending order
        
        // Find the first element that is not equal to the largest element
        for i in 1..<sortedArray.count {
            if sortedArray[i] != sortedArray[0] {
                return sortedArray[i]
            }
        }
        
        return nil // All elements are the same
    }
    
    // MARK: - Method 2: Using Set and max()
    func findSecondLargestUsingSet(in array: [Int]) -> Int? {
        guard array.count >= 2 else {
            return nil
        }
        
        let uniqueNumbers = Array(Set(array)).sorted(by: >) // Remove duplicates and sort
        
        guard uniqueNumbers.count >= 2 else {
            return nil // Either fewer than 2 unique elements or all elements were the same
        }
        
        return uniqueNumbers[1]
    }
}

#Preview {
    Arrays_Problem3()
}
