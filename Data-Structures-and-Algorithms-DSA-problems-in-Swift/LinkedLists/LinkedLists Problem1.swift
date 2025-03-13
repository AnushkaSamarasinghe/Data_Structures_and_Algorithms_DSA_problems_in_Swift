//
//  LinkedLists Problem1.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

/*
 MARK: - Problem: Reverse a Linked List in Groups of Given Size
 
 Given a linked list and a group size `k`, reverse the nodes in groups of `k`. If the remaining nodes are less than `k`, reverse them as well.
 
 Example Input: 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8, k = 3
 Expected Output: 3 -> 2 -> 1 -> 6 -> 5 -> 4 -> 8 -> 7
 
 ===================
 
 MARK: - Solution Approaches:
 
 Method 1: Iterative Approach
 - This method reverses the linked list in groups by manipulating pointers.
 - Most efficient in terms of space complexity (O(1)).
 
 Method 2: Recursive Approach
 - This method uses recursion to reverse groups of nodes.
 - More elegant but uses stack space for recursion.
 */

import SwiftUI

// Node class for LinkedList
class ListNode {
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// LinkedList class with helper methods
class LinkedList {
    var head: ListNode?
    
    // Convert array to LinkedList
    func arrayToList(_ arr: [Int]) {
        head = nil
        var current: ListNode?
        
        for val in arr {
            let newNode = ListNode(val)
            if head == nil {
                head = newNode
                current = head
            } else {
                current?.next = newNode
                current = newNode
            }
        }
    }
    
    // Convert LinkedList to array for display
    func toArray() -> [Int] {
        var result: [Int] = []
        var current = head
        
        while current != nil {
            result.append(current!.val)
            current = current?.next
        }
        return result
    }
    
    // MARK: - Method 1: Iterative Approach
    func reverseKGroupIterative(_ k: Int) {
        guard k > 1 else { return }
        
        var current = head
        var prev: ListNode?
        var next: ListNode?
        var temp: ListNode?
        
        // Count total nodes
        var count = 0
        temp = head
        while temp != nil {
            count += 1
            temp = temp?.next
        }
        
        var tempHead = head
        
        while count >= k {
            var localCount = k
            current = tempHead
            prev = nil
            
            // Reverse k nodes
            while localCount > 0 {
                next = current?.next
                current?.next = prev
                prev = current
                current = next
                localCount -= 1
            }
            
            // Connect with previous group
            if head === tempHead {
                head = prev
            } else {
                temp?.next = prev
            }
            
            // Update for next group
            temp = tempHead
            tempHead?.next = current
            tempHead = current
            count -= k
        }
        
        // Reverse remaining nodes if any
        if count > 0 {
            current = tempHead
            prev = nil
            
            while current != nil {
                next = current?.next
                current?.next = prev
                prev = current
                current = next
            }
            temp?.next = prev
        }
    }
    
    // MARK: - Method 2: Recursive Approach
    func reverseKGroupRecursive(_ k: Int) {
        guard k > 1 else { return }
        head = reverseKGroupRecursiveHelper(head, k)
    }
    
    private func reverseKGroupRecursiveHelper(_ head: ListNode?, _ k: Int) -> ListNode? {
        // Base case
        guard head != nil else { return nil }
        
        // Check if we have k nodes
        var count = 0
        var temp = head
        while count < k && temp != nil {
            temp = temp?.next
            count += 1
        }
        
        // If k nodes exist, reverse them
        if count == k {
            var current = head
            var prev: ListNode?
            var next: ListNode?
            count = 0
            
            // Reverse k nodes
            while count < k && current != nil {
                next = current?.next
                current?.next = prev
                prev = current
                current = next
                count += 1
            }
            
            // Recursively reverse next group
            if next != nil {
                head?.next = reverseKGroupRecursiveHelper(next, k)
            }
            return prev
        }
        
        // If less than k nodes, reverse them all
        var current = head
        var prev: ListNode?
        var next: ListNode?
        
        while current != nil {
            next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        return prev
    }
}

struct LinkedLists_Problem1: View {
    @State private var list1 = [1, 2, 3, 4, 5, 6, 7, 8]
    @State private var list2 = [1, 2, 3, 4, 5, 6, 7, 8]
    @State private var k1 = 3
    @State private var k2 = 3
    @State private var linkedList1 = LinkedList()
    @State private var linkedList2 = LinkedList()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Method 1: Iterative Approach
                VStack(alignment: .leading) {
                    HStack {
                        Text("Method 1: Iterative Approach")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    VStack(alignment: .leading) {
                        Text("LinkedList: \(list1.map { String($0) }.joined(separator: " → "))")
                        Spacer()
                        Stepper("K: \(k1)", value: $k1, in: 1...list1.count)
                    }//: VStack
                    
                    CustomButton(buttonName: "Reverse in Groups (Iterative)", buttonColor: .blue) {
                        linkedList1.arrayToList(list1)
                        linkedList1.reverseKGroupIterative(k1)
                        list1 = linkedList1.toArray()
                    }
                }//: VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                // Method 2: Recursive Approach
                VStack(alignment: .leading) {
                    HStack {
                        Text("Method 2: Recursive Approach")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    VStack(alignment: .leading) {
                        Text("LinkedList: \(list2.map { String($0) }.joined(separator: " → "))")
                        Spacer()
                        Stepper("K: \(k2)", value: $k2, in: 1...list2.count)
                    }//: VStack
                    
                    CustomButton(buttonName: "Reverse in Groups (Recursive)", buttonColor: .blue) {
                        linkedList2.arrayToList(list2)
                        linkedList2.reverseKGroupRecursive(k2)
                        list2 = linkedList2.toArray()
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
        .navigationTitle("LinkedList Problem 1")
    }
}

#Preview {
    LinkedLists_Problem1()
}
