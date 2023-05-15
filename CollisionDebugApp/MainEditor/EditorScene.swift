//
//  EditorScene.swift
//  CollisionDebugApp
//
//  Created by Nail Sharipov on 14.05.2023.
//

import SwiftUI
import iFixBox
import iFixFloat

final class EditorScene: ObservableObject {
    
    static let colorA: Color = .blue
    static let colorB: Color = .green
    
    
    let editorA = VertextEditorScene(color: colorA, name: "Polygon A")
    let editorB = VertextEditorScene(color: colorB, name: "Polygon B")
    let solver = SolverScene(colorA: colorA, colorB: colorB)
    
    private var test = TestData.tests[0]
    
    private (set) var pointsA: [CGPoint] = []
    private (set) var pointsB: [CGPoint] = []

    @Published
    var rotA: Float = 0 {
        didSet {
            solver.rotA = rotA
        }
    }
    
    @Published
    var rotB: Float = 0 {
        didSet {
            solver.rotB = rotB
        }
    }
    
    var testIndex: Int = 0 {
        didSet {
            loadTest()
        }
    }
    
    init() {
        editorA.contourEditor.onUpdate = { [weak self] points in
            guard let self = self else { return }
            self.solver.shapeA = points
        }
        editorB.contourEditor.onUpdate = { [weak self] points in
            guard let self = self else { return }
            self.solver.shapeB = points
        }
    }
    
    
    func makeView() -> EditorSceneView {
        EditorSceneView(scene: self)
    }

    private func loadTest() {
        test = TestData.tests[testIndex]
        editorA.points = test.poligonA
        editorB.points = test.poligonB

        rotA = test.rotA
        rotB = test.rotB
        
        solver.load(test: test)
    }
    
}
