//
//  EditorSceneView.swift
//  CollisionDebugApp
//
//  Created by Nail Sharipov on 14.05.2023.
//

import SwiftUI

struct EditorSceneView: View {
 
    @ObservedObject
    var scene: EditorScene
    
    var body: some View {
        return HStack {
            ZStack {
                Color.white
                Color.yellow.opacity(0.2)
                scene.solver.makeView()
                ZStack {
                    VStack {
                        HStack {
                            Text("A rot: \(Int(scene.rotA))")
                                .frame(width: 80)
                                .font(.title3).foregroundColor(EditorScene.colorA)
                            Slider(value: $scene.rotA, in: 0...360).padding(.trailing, 8)
                            Text("B rot: \(Int(scene.rotB))")
                                .frame(width: 80)
                                .font(.title3).foregroundColor(EditorScene.colorB)
                            Slider(value: $scene.rotB, in: 0...360).padding(.trailing, 8)
                        }.padding()
                        Spacer()
                    }
                }
            }
            VStack {
                scene.editorA.makeView()
                scene.editorB.makeView()
            }
        }
    }

}
