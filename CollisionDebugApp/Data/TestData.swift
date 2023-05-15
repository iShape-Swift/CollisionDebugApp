//
//  TestData.swift
//  CollisionDebugApp
//
//  Created by Nail Sharipov on 14.05.2023.
//

import CoreGraphics

struct Test {
    let name: String
    let poligonA: [CGPoint]
    let posA: CGPoint
    let rotA: Float
    let poligonB: [CGPoint]
    let posB: CGPoint
    let rotB: Float
    
    init(name: String, poligonA: [CGPoint], posA: CGPoint = .zero, rotA: Float = 0, poligonB: [CGPoint], posB: CGPoint = .zero, rotB: Float = 0) {
        self.name = name
        self.poligonA = poligonA
        self.posA = posA
        self.rotA = rotA
        self.poligonB = poligonB
        self.posB = posB
        self.rotB = rotB
    }
    
}

struct TestTitle: Identifiable {
    let id: Int
    let name: String
}


struct TestData {

    static let titles: [TestTitle] = {
        var result = [TestTitle]()
        for i in 0..<tests.count {
            result.append(TestTitle(id: i, name: tests[i].name))
        }
        
        return result
    }()
    
    static let tests = [
        Test(
            name: "Two boxes",
            poligonA: [
                .init(x: -10, y: -10),
                .init(x: -10, y:  10),
                .init(x:  10, y:  10),
                .init(x:  10, y: -10)
            ],
            posA: CGPoint(x: 0, y: 10),
            poligonB: [
                .init(x: -10, y: -10),
                .init(x: -10, y:  10),
                .init(x:  10, y:  10),
                .init(x:  10, y: -10)
            ],
            posB: CGPoint(x: 0, y: -10)
        ),
        Test(
            name: "Rect and square",
            poligonA: [
                .init(x: -10, y: -10),
                .init(x: -10, y:  10),
                .init(x:  10, y:  10),
                .init(x:  10, y: -10)
            ],
            posA: CGPoint(x: 0, y: 5),
            poligonB: [
                .init(x: -15, y: -10),
                .init(x: -15, y:  10),
                .init(x:  15, y:  10),
                .init(x:  15, y: -10)
            ],
            posB: CGPoint(x: 0, y: -5)
        ),
        Test(
            name: "Long rects",
            poligonA: [
                .init(x: -5, y: -30),
                .init(x: -5, y:  30),
                .init(x:  5, y:  30),
                .init(x:  5, y: -30)
            ],
            posA: CGPoint(x: -2, y: -7),
            rotA: 21,
            poligonB: [
                .init(x: -5, y: -30),
                .init(x: -5, y:  30),
                .init(x:  5, y:  30),
                .init(x:  5, y: -30)
            ],
            posB: CGPoint(x: 15, y: 15),
            rotB: 271
        ),
        Test(
            name: "250 box",
            poligonA: [
                .init(x: -10, y: -10),
                .init(x: -10, y:  10),
                .init(x:  10, y:  10),
                .init(x:  10, y: -10)
            ],
            posA: CGPoint(x: 0, y: 10),
            poligonB: [
                .init(x: -10, y: -10),
                .init(x: -10, y:  10),
                .init(x:  10, y:  10),
                .init(x:  10, y: -10)
            ],
            posB: CGPoint(x: 0, y: -10),
            rotB: 250
        ),
    ]

}
