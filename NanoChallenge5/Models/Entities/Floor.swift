//
//  Floor.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class Floor: SCNNode {

    convenience init(at position: SCNVector3) {
        self.init()
        addGeometry()
        addPhysics()
        move(to: position)
        opacity = 0
    }
    
    private func addGeometry() {
        geometry = SCNBox(width: 1000, height: 10, length: 1000, chamferRadius: 0)
    }
    
    private func addPhysics() {
        physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        physicsBody!.restitution = 0.4
        physicsBody!.categoryBitMask = Physics.CategoryBitMask.floor
    }
    
    private func move(to position: SCNVector3) {
        let box = geometry as! SCNBox
        let offset = SCNVector3(0, -Float(box.height / 2), 0)
        self.position = position + offset
    }
}
