//
//  CGPoint+Vector.swift
//  CollisionDebugApp
//
//  Created by Nail Sharipov on 14.05.2023.
//

import CoreGraphics
import iFixFloat

extension CGPoint {
    
    var length: CGFloat {
        (x * x + y * y).squareRoot()
    }
    
    var magnitude: CGFloat {
        x * x + y * y
    }
    
    var normalize: CGPoint {
        let l = self.length
        return CGPoint(x: x / l, y: y / l)
    }
    
    var fixVec: FixVec {
        FixVec(x.fix, y.fix)
    }
    
    func round(scale: CGFloat) -> CGPoint {
        let rx = (x / scale).rounded() * scale
        let ry = (y / scale).rounded() * scale
        return CGPoint(x: rx, y: ry)
    }

}

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(left: CGFloat, right: CGPoint) -> CGPoint {
    CGPoint(x: left * right.x, y: left * right.y)
}

func /(left: CGPoint, right: CGFloat) -> CGPoint {
    CGPoint(x: left.x / right, y: left.y / right)
}

extension FixVec {
    
    var point: CGPoint {
        CGPoint(x: x.cgFloat, y: y.cgFloat)
    }
    
}
