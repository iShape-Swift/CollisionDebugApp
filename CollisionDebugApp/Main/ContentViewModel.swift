//
//  ContentViewModel.swift
//  CollisionDebugApp
//
//  Created by Nail Sharipov on 14.05.2023.
//

import SwiftUI

final class ContentViewModel: ObservableObject {

    private let editorScene = EditorScene()

    private (set) var index = PersistInt(key: "TestIndex", nilValue: 0)
    
    let tests: [TestTitle] = TestData.titles
    
    @Published
    var selection: Int = 0 {
        didSet {
            index.value = selection
            editorScene.testIndex = index.value
        }
    }

    @ViewBuilder var contentView: some View {
        editorScene.makeView()
    }
    
    func onAppear() {
        if index.value != selection {
            selection = index.value
        } else {
            editorScene.testIndex = index.value
        }
    }
}

