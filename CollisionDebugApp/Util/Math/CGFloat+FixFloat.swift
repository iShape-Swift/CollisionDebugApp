//
//  CGFloat+FixFloat.swift
//  CollisionDebugApp
//
//  Created by Nail Sharipov on 14.05.2023.
//

import CoreGraphics
import iFixFloat

extension Float {
    var gradToRad: Float {
        (self / 180) * .pi
    }
}

extension CGFloat {
    
    var fix: FixFloat {
        Float(self).fix
    }
    
}

extension FixFloat {
    
    var cgFloat: CGFloat {
        CGFloat(self.double)
    }
    
}
