//
//  PointsEditor.swift
//  EditorScene
//
//  Created by Nail Sharipov on 21.03.2023.
//

import SwiftUI

final class PointsEditor: ObservableObject {

    var matrix: Matrix = .empty
    var onUpdate: (([CGPoint]) -> ())?

    private (set) var points: [CGPoint] = []
    private (set) var screenPoints: [CGPoint] = []
    
    private var selectedId = -1
    private var selectedStart: CGPoint = .zero
    private let scale: CGFloat
    
    init(scale: CGFloat = 1) {
        self.scale = scale
    }
    
    var dots: [EditorDot] {
        var buffer = [EditorDot](repeating: .empty, count: screenPoints.count)
        let radius: CGFloat = 3
        let touchRadius: CGFloat = 22
        for i in 0..<screenPoints.count {
            let center = screenPoints[i] - CGPoint(x: radius, y: radius)
            let touchCenter = screenPoints[i] - CGPoint(x: touchRadius, y: touchRadius)
            let touchColor: Color = selectedId == i ? .black.opacity(0.15) : .black.opacity(0.05)
            
            buffer[i] = EditorDot(
                id: i,
                center: center,
                touchCenter: touchCenter,
                radius: radius,
                touchRadius: touchRadius,
                color: .gray,
                touchColor: touchColor,
                title: String(i)
            )
        }

        return buffer
    }
    
    func set(points: [CGPoint]) {
        self.points = points
        self.reload()
    }
    
    func makeView() -> PointsEditorView {
        PointsEditorView(editor: self)
    }
    
    func onDrag(id: Int, move: CGSize) {
        if selectedId == -1 {
            selectedId = id
            selectedStart = points[id]
        }
        update(id: id, move: move)
    }

    func onEnd(id: Int, move: CGSize) {
        selectedId = -1
        update(id: id, move: move)
    }
    
    private func update(id: Int, move: CGSize) {
        let newPoint = selectedStart + matrix.world(screenVector: CGPoint(x: move.width, y: move.height))
        if newPoint != points[id] || selectedId == -1 {
            points[id] = newPoint.round(scale: scale)
            self.reload()
            onUpdate?(points)
        }
    }
    
    func reload() {
        screenPoints = matrix.screen(wordPoints: points)
        self.objectWillChange.send()
    }
    
}
