//
//  VertextEditorSceneView.swift
//  EditorScene
//
//  Created by Nail Sharipov on 14.05.2023.
//

import SwiftUI

struct VertextEditorSceneView: View {
 
    @ObservedObject
    var scene: VertextEditorScene
    
    var body: some View {
        GeometryReader { proxy in
            content(size: proxy.size)
        }
    }
    
    private func content(size: CGSize) -> some View {
        scene.initSize(screenSize: size)
        return ZStack {
            Color.white
            scene.color.opacity(0.2)
            VStack {
                Text(scene.name).font(.title2).foregroundColor(scene.color).padding(.top)
                Spacer()
            }
            scene.vertexView()
        }
    }
    
}
