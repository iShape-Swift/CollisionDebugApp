//
//  ContentView.swift
//  CollisionDebugApp
//
//  Created by Nail Sharipov on 14.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject
    var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.tests, selection: $viewModel.selection) { test in
                Text(test.name)
            }
        } detail: {
            viewModel.contentView
        }
        .navigationTitle("Collision App")
        .navigationSubtitle("Test")
        .onAppear() {
            viewModel.onAppear()
        }
    }
}
