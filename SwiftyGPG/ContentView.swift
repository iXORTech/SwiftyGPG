//
//  ContentView.swift
//  SwiftyGPG
//
//  Created by Cubik65536 on 2024-06-12.
//

import SwiftUI

struct Tree: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var children: [Tree]? = nil
}

enum SideBar: Hashable {
    case number(Int)
    case tree(Tree)
}

struct ContentView: View {
    let trees = [
        Tree(name: "One", children: [Tree(name: "One-1"), Tree(name: "One-2"), Tree(name: "One-3")]),
        Tree(name: "Two", children: [Tree(name: "Two-1"), Tree(name: "Two-2"), Tree(name: "Two-3")]),
        Tree(name: "Three"),
    ]
    
    @State private var selection: SideBar?
    @State private var text = ""
    @State private var bold = false
    @State private var italic = false
    @State private var fontSize = 12.0
    @State private var showInspector = false
    
    func refresh() {
        
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Button("Refresh", systemImage: "arrow.clockwise.circle", action: refresh).labelStyle(.iconOnly)
                
                Section("Numbers") {
                    ForEach(1..<6) { number in
                        NavigationLink("\(number)", value: SideBar.number(number))
                    }
                }
                
                Section("Tree") {
                    OutlineGroup(trees, children: \.children) { tree in
                        NavigationLink(tree.name, value: SideBar.tree(tree))
                    }
                }
            }
            
        } detail: {
            HStack {
                switch selection  {
                case .number(let nr):
                    Text("Number \(nr)")
                        .navigationTitle("Numbers")
                case .tree(let tree):
                    Text("Tree element \(tree.name)")
                        .navigationTitle("Tree")
                    
                case nil:
                    Text("please choose")
                }
            }
            .inspector(isPresented: $showInspector) {
                Text("Inspector")
                    .inspectorColumnWidth(min: 200, ideal: 300, max: 400)
            }
        } .toolbar {
            Spacer()
            Button {
                showInspector.toggle()
            } label: {
                Label("Toggle Inspector", systemImage: "sidebar.right")
            }
        }
    }
}

#Preview {
    ContentView()
}
