//
//  SolverSceneView.swift
//  CollisionDebugApp
//
//  Created by Nail Sharipov on 14.05.2023.
//

import SwiftUI

struct SolverSceneView: View {
    @ObservedObject
    var scene: SolverScene
    
    var body: some View {
        return HStack {
            GeometryReader { proxy in
                content(size: proxy.size)
            }
        }
    }
    
    private func content(size: CGSize) -> some View {
        scene.initSize(screenSize: size)
        return ZStack {
            Color.white
            Color.yellow.opacity(0.2)
            scene.dotEditor.makeView()
            Path { path in
                path.addLines(scene.pointsA)
                path.closeSubpath()
            }
            .strokedPath(.init(lineWidth: 2))
            .foregroundColor(.blue)
            Path { path in
                path.addLines(scene.pointsB)
                path.closeSubpath()
            }
            .strokedPath(.init(lineWidth: 2))
            .foregroundColor(.green)
            
            ForEach(scene.crossDots) { dot in
                Circle()
                    .size(width: 2 * dot.radius, height: 2 * dot.radius)
                    .offset(dot.center)
                    .foregroundColor(dot.color)
            }
        }
    }
}
