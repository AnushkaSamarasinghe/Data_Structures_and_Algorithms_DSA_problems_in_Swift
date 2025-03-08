//
//  ContentView.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Arrays")) {
                    NavigationLink("Arrays Problem1") {
                        Arrays_Problem1()
                    }
                    NavigationLink("Arrays Problem2") {
                        Arrays_Problem2()
                    }
                }//: Section
                
                Section(header: Text("LinkedLists")) {
                    NavigationLink("LinkedLists Problem1") {
                        LinkedLists_Problem1()
                    }
                }//: Section
                
                Section(header: Text("Trees")) {
                    NavigationLink("Trees Problem1") {
                        Trees_Problem1()
                    }
                }//: Section
                
                Section(header: Text("Graphs")) {
                    NavigationLink("Graphs Problem1") {
                        Graphs_Problem1()
                    }
                }//: Section
                
                Section(header: Text("Sorting")) {
                    NavigationLink("QuickSort") {
                        QuickSort()
                    }
                    NavigationLink("MergeSort") {
                        MergeSort()
                    }
                }//: Section
            }//: List
            .navigationTitle("DSA problems in Swift")
        }//: NavigationStack
    }
}

#Preview {
    ContentView()
}
