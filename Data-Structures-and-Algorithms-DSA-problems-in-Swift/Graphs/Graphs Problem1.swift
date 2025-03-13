//
//  Graphs Problem1.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

/*
 MARK: - Problem: Find Shortest Path Between Two Nodes
 
 Given an undirected graph and two nodes, find the shortest path between them.
 Return the path as an array of node values.
 
 Example Input:
 Graph:
 1 --- 2 --- 5
 |     |     |
 3 --- 4 --- 6
 
 Start: 1, End: 6
 Expected Output: [1, 3, 4, 6]
 
 ===================
 
 MARK: - Solution Approaches:
 
 Method 1: Breadth-First Search (BFS)
 - Uses queue to explore nodes level by level
 - Guarantees shortest path in unweighted graphs
 - Time Complexity: O(V + E), Space Complexity: O(V)
 
 Method 2: Depth-First Search (DFS)
 - Uses recursion to explore paths
 - May not find shortest path but can find all possible paths
 - Time Complexity: O(V + E), Space Complexity: O(V)
 */

import SwiftUI

// Graph class using adjacency list representation
class Graph {
    private var adjacencyList: [Int: Set<Int>]
    
    init() {
        adjacencyList = [:]
    }
    
    // Add edge between two nodes
    func addEdge(_ from: Int, _ to: Int) {
        adjacencyList[from, default: Set()].insert(to)
        adjacencyList[to, default: Set()].insert(from) // For undirected graph
    }
    
    // Create sample graph from array of edges
    func createSampleGraph(_ edges: [(Int, Int)]) {
        adjacencyList.removeAll()
        for edge in edges {
            addEdge(edge.0, edge.1)
        }
    }
    
    // MARK: - Method 1: BFS Shortest Path
    func findShortestPathBFS(from start: Int, to end: Int) -> [Int] {
        var queue = [(node: start, path: [start])]
        var visited = Set<Int>()
        
        while !queue.isEmpty {
            let (node, path) = queue.removeFirst()
            
            if node == end {
                return path
            }
            
            if !visited.contains(node) {
                visited.insert(node)
                
                // Add all unvisited neighbors to queue
                for neighbor in adjacencyList[node, default: Set()] {
                    if !visited.contains(neighbor) {
                        queue.append((neighbor, path + [neighbor]))
                    }
                }
            }
        }
        return [] // No path found
    }
    
    // MARK: - Method 2: DFS All Paths
    func findAllPathsDFS(from start: Int, to end: Int) -> [[Int]] {
        var visited = Set<Int>()
        var allPaths = [[Int]]()
        var currentPath = [start]
        
        dfsHelper(current: start, end: end, visited: &visited, path: &currentPath, allPaths: &allPaths)
        
        // Sort paths by length to get shortest first
        return allPaths.sorted { $0.count < $1.count }
    }
    
    private func dfsHelper(current: Int, end: Int, visited: inout Set<Int>, path: inout [Int], allPaths: inout [[Int]]) {
        if current == end {
            allPaths.append(path)
            return
        }
        visited.insert(current)
        
        for neighbor in adjacencyList[current, default: Set()] {
            if !visited.contains(neighbor) {
                path.append(neighbor)
                dfsHelper(current: neighbor, end: end, visited: &visited, path: &path, allPaths: &allPaths)
                path.removeLast()
            }
        }
        visited.remove(current)
    }
}

struct Graphs_Problem1: View {
    @State private var sampleEdges = [(1, 2), (1, 3), (2, 4), (2, 5), (3, 4), (4, 6), (5, 6)]
    @State private var startNode = 1
    @State private var endNode = 6
    @State private var bfsPath: [Int] = []
    @State private var dfsPaths: [[Int]] = []
    @State private var graph = Graph()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Graph Visualization
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Graph Structure")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    Text("Edges: \(formatEdges(sampleEdges))")
                        .padding(.vertical)
                    
                    VStack {
                        Stepper("Start Node: \(startNode)", value: $startNode, in: 1...6)
                        Divider()
                        Stepper("End Node: \(endNode)", value: $endNode, in: 1...6)
                    }//: VStack
                }//: VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                // Method 1: BFS Approach
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Method 1: BFS Shortest Path")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    if !bfsPath.isEmpty {
                        Text("Shortest Path: \(formatPath(bfsPath))")
                    } else {
                        Text("No path found")
                    }
                    
                    CustomButton(buttonName: "Find Shortest Path (BFS)", buttonColor: .blue) {
                        graph.createSampleGraph(sampleEdges)
                        bfsPath = graph.findShortestPathBFS(from: startNode, to: endNode)
                    }
                }//: VStack
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                // Method 2: DFS Approach
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Method 2: DFS All Paths")
                            .font(.headline)
                        Spacer()
                    }//: HStack
                    
                    if !dfsPaths.isEmpty {
                        ForEach(0..<dfsPaths.count, id: \.self) { i in
                            Text("Path \(i + 1): \(formatPath(dfsPaths[i]))")
                        }
                    } else {
                        Text("No paths found")
                    }
                    
                    CustomButton(buttonName: "Find All Paths (DFS)", buttonColor: .blue) {
                        graph.createSampleGraph(sampleEdges)
                        dfsPaths = graph.findAllPathsDFS(from: startNode, to: endNode)
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
        .navigationTitle("Graphs Problem 1")
    }
    
    // Helper functions to format output
    private func formatEdges(_ edges: [(Int, Int)]) -> String {
        return edges.map { "(\($0.0)-\($0.1))" }.joined(separator: ", ")
    }
    
    private func formatPath(_ path: [Int]) -> String {
        return path.map { String($0) }.joined(separator: " → ")
    }
}

#Preview {
    Graphs_Problem1()
}
