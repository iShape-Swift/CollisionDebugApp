//
//  VertextEditorScene.swift
//  EditorScene
//
//  Created by Nail Sharipov on 14.05.2023.
//

import SwiftUI
import iFixBox
import iFixFloat
import iDebug

final class VertextEditorScene: ObservableObject {
    
    var points: [CGPoint] = [] {
        didSet {
            reload()
        }
    }

    let color: Color
    let name: String
    
    init(color: Color, name: String) {
        self.color = color
        self.name = name
    }
    
    private var matrix: Matrix = .empty
    let contourEditor = ContourEditor()

    func makeView() -> VertextEditorSceneView {
        VertextEditorSceneView(scene: self)
    }

    func vertexView() -> ContourEditorView {
        contourEditor.makeView(matrix: matrix)
    }
    
    func initSize(screenSize: CGSize) {
        if !matrix.screenSize.isIntSame(screenSize) {
            matrix = Matrix(screenSize: screenSize, scale: 10, inverseY: true)
        }
    }

    func reload() {
        contourEditor.set(points: points)
    }
    
}
