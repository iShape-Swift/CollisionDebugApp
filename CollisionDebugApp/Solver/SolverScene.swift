//
//  SolverScene.swift
//  CollisionDebugApp
//
//  Created by Nail Sharipov on 14.05.2023.
//

import SwiftUI
import iFixBox
import iFixFloat

struct CrossDot: Identifiable {
    
    let id: Int
    let center: CGPoint
    let radius: CGFloat
    let color: Color
}

final class SolverScene: ObservableObject {

    let dotEditor: PointsEditor

    private (set) var crossDots: [CrossDot] = []
    
    // ui
    private (set) var pointsA: [CGPoint] = []
    private (set) var pointsB: [CGPoint] = []

    // data
    
    var shapeA: [CGPoint] = [] {
        didSet {
            solve()
        }
    }
    
    var shapeB: [CGPoint] = [] {
        didSet {
            solve()
        }
    }
    
    private (set) var posA: CGPoint = .zero
    private (set) var posB: CGPoint = .zero

    var rotA: Float = 0 {
        didSet {
            solve()
        }
    }
    
    var rotB: Float = 0 {
        didSet {
            solve()
        }
    }

    private var matrix: Matrix = .empty
    private var isTestLoaded = false

    let colorA: Color
    let colorB: Color
    
    init(colorA: Color, colorB: Color) {
        self.colorA = colorA
        self.colorB = colorB
        
        dotEditor = PointsEditor(scale: 1)
        dotEditor.set(points: [posA, posB])

        dotEditor.onUpdate = { [weak self] points in
            guard let self = self else { return }
            self.posA = points[0]
            self.posB = points[1]
            self.solve()
        }
    }
    
    func load(test: Test) {
        shapeA = test.poligonA
        shapeB = test.poligonB
        
        posA = test.posA
        posB = test.posB

        rotA = test.rotA
        rotB = test.rotB
        
        dotEditor.set(points: [posA, posB])
        
        isTestLoaded  = true
        self.solve()
    }
    
    func makeView() -> SolverSceneView {
        SolverSceneView(scene: self)
    }
    
    func initSize(screenSize: CGSize) {
        if !matrix.screenSize.isIntSame(screenSize) {
            matrix = Matrix(screenSize: screenSize, scale: 10, inverseY: true)
            dotEditor.matrix = matrix
            DispatchQueue.main.async { [weak self] in
                self?.solve()
                self?.dotEditor.reload()
            }
        }
    }

    private func solve() {
        guard isTestLoaded else { return }
        
        let pntsA = shapeA.map({ $0.fixVec })
        let pntsB = shapeB.map({ $0.fixVec })

        let trA = Transform(position: posA.fixVec, angle: rotA.gradToRad.fix)
        pointsA = matrix.screen(wordPoints: trA.convertAsPoints(pntsA).map({ $0.point }))

        let trB = Transform(position: posB.fixVec, angle: rotB.gradToRad.fix)
        pointsB = matrix.screen(wordPoints: trB.convertAsPoints(pntsB).map({ $0.point }))

        let a = ConvexCollider(points: pntsA)
        let b = ConvexCollider(points: pntsB)
        
        let colSolver = CollisionSolver()
        
//        let contact = colSolver.collide(a, b, tA: trA, tB: trB)
        
        // for test transform B in A
        
        let mt = Transform.convertFromBtoA(trB, trA)
        
        let b2 = ConvexCollider(transform: mt, collider: b)
        let dots = ConvexIntersectSolver.intersect(a: a, b: b2)
        
        crossDots.removeAll()
        let r: CGFloat = 4
        for i in 0..<dots.count {
            let d = trA.convertAsPoint(dots[i].p).point
            let c = matrix.screen(worldPoint: d) - CGPoint(x: r, y: r)
            let crDot = CrossDot(id: i, center: c, radius: r, color: .red)
            crossDots.append(crDot)
        }

        self.objectWillChange.send()
    }
    
}
