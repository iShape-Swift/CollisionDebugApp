//
//  SolverSceneView.swift
//  CollisionDebugApp
//
//  Created by Nail Sharipov on 14.05.2023.
//

import SwiftUI
import iDebug

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
            
            if let contact = scene.contact {
                Circle()
                    .size(width: 4, height: 4)
                    .offset(contact.start - CGPoint(x: 2, y: 2))
                    .foregroundColor(.red)
                Path { path in
                    path.move(to: contact.start)
                    path.addLine(to: contact.end)
                }
                .strokedPath(.init(lineWidth: 2))
                .foregroundColor(.red)
                Text(contact.title).font(.title3).foregroundColor(.black).position(contact.start - CGPoint(x: 2, y: 24))
            }
        }
    }
}
