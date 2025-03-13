//
//  Trees Problem1.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

/*
 MARK: - Problem: Level-wise Reversal of Binary Tree
 
 Given a binary tree, reverse the nodes at each level.
 
 Example Input:
      1
    /   \
   2     3
  / \   / \
 4   5 6   7
 
 Expected Output:
      1
    /   \
   3     2
  / \   / \
 7   6 5   4
 
 ===================
 
 MARK: - Solution Approaches:
 
 Method 1: Iterative Level-Order Approach
 - Uses queue for level-order traversal and reverses nodes at each level
 - Time Complexity: O(n), Space Complexity: O(w) where w is max width
 
 Method 2: Recursive Level-Map Approach
 - Uses recursion with a dictionary to map levels to nodes
 - More intuitive but uses more space
 */

import SwiftUI

// TreeNode class for Binary Tree
class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
    }
}

// BinaryTree class with helper methods
class BinaryTree {
    var root: TreeNode?
    
    // Convert array to Complete Binary Tree
    func arrayToTree(_ arr: [Int?]) {
        guard !arr.isEmpty, let firstVal = arr[0] else { return }
        
        root = TreeNode(firstVal)
        var queue = [root]
        var i = 1
        
        while i < arr.count && !queue.isEmpty {
            let node = queue.removeFirst()
            
            // Add left child
            if i < arr.count, let leftVal = arr[i] {
                node?.left = TreeNode(leftVal)
                queue.append(node?.left)
            }
            i += 1
            
            // Add right child
            if i < arr.count, let rightVal = arr[i] {
                node?.right = TreeNode(rightVal)
                queue.append(node?.right)
            }
            i += 1
        }
    }
    
    // Convert Binary Tree to array for display
    func treeToArray() -> [Int?] {
        guard let root = root else { return [] }
        
        var result: [Int?] = []
        var queue = [TreeNode?]([root])
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            result.append(node?.val)
            
            if node != nil {
                queue.append(node?.left)
                queue.append(node?.right)
            }
        }
        
        // Remove trailing nulls
        while let last = result.last, last == nil {
            result.removeLast()
        }
        return result
    }
    
    // MARK: - Method 1: Iterative Level-Order Approach
    func reverseLevelsIterative() {
        guard let root = root else { return }
        
        var queue = [TreeNode]([root])
        
        while !queue.isEmpty {
            let size = queue.count
            var levelNodes = [TreeNode]()
            
            // Collect nodes at current level
            for _ in 0..<size {
                let node = queue.removeFirst()
                levelNodes.append(node)
                
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            
            // Reverse values at current level
            for i in 0..<levelNodes.count/2 {
                let temp = levelNodes[i].val
                levelNodes[i].val = levelNodes[levelNodes.count-1-i].val
                levelNodes[levelNodes.count-1-i].val = temp
            }
        }
    }
    
    // MARK: - Method 2: Recursive Level-Map Approach
    func reverseLevelsRecursive() {
        var levelMap = [Int: [TreeNode]]()
        mapNodesToLevels(root, 0, &levelMap)
        
        // Reverse nodes at each level
        for (_, nodes) in levelMap {
            for i in 0..<nodes.count/2 {
                let temp = nodes[i].val
                nodes[i].val = nodes[nodes.count-1-i].val
                nodes[nodes.count-1-i].val = temp
            }
        }
    }
    
    private func mapNodesToLevels(_ node: TreeNode?, _ level: Int, _ levelMap: inout [Int: [TreeNode]]) {
        guard let node = node else { return }
        
        // Add node to its level in the map
        levelMap[level, default: []].append(node)
        
        // Recursively process children
        mapNodesToLevels(node.left, level + 1, &levelMap)
        mapNodesToLevels(node.right, level + 1, &levelMap)
    }
}

struct Trees_Problem1: View {
    @State private var tree1: [Int?] = [1, 2, 3, 4, 5, 6, 7]
    @State private var tree2: [Int?] = [1, 2, 3, 4, 5, 6, 7]
    @State private var binaryTree1 = BinaryTree()
    @State private var binaryTree2 = BinaryTree()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Method 1: Iterative Level-Order Approach
                VStack(alignment: .leading) {
                    HStack {
                        Text("Method 1: Iterative Level-Order Approach")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    Text("Tree: \(formatTreeArray(tree1))")
                        .padding(.vertical)
                    
                    CustomButton(buttonName: "Reverse Levels (Iterative)", buttonColor: .blue) {
                        binaryTree1.arrayToTree(tree1)
                        binaryTree1.reverseLevelsIterative()
                        tree1 = binaryTree1.treeToArray()
                    }
                }//: VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                // Method 2: Recursive Level-Map Approach
                VStack(alignment: .leading) {
                    HStack {
                        Text("Method 2: Recursive Level-Map Approach")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    Text("Tree: \(formatTreeArray(tree2))")
                        .padding(.vertical)
                    
                    CustomButton(buttonName: "Reverse Levels (Recursive)", buttonColor: .blue) {
                        binaryTree2.arrayToTree(tree2)
                        binaryTree2.reverseLevelsRecursive()
                        tree2 = binaryTree2.treeToArray()
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
        .navigationTitle("Trees Problem 1")
    }
    
    // Helper function to format tree array for display
    private func formatTreeArray(_ arr: [Int?]) -> String {
        return arr.map { $0 != nil ? String($0!) : "null" }.joined(separator: ", ")
    }
}

#Preview {
    Trees_Problem1()
}
