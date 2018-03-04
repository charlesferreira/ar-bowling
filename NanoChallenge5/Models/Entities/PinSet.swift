//
//  PinSet.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class PinSet: SCNNode {
    
    private static let shared = PinSet(position: SCNVector3Zero, model: SCNScene(named: Constants.Models.pins)!.rootNode)
    
    static func create(position: SCNVector3) -> PinSet {
        let pinSet = shared.clone()
        pinSet.position = position
        return pinSet
    }
    
    private convenience init(position: SCNVector3, model: SCNNode) {
        self.init()
        
//        for pin in pinsPlaceholder.childNodes {
//            pin.physicsBody = pinPhysicsBody()
//        }
    }
    
    private func setUpPhysicsBody() -> SCNPhysicsBody {
        let cylinder = SCNCylinder(radius: 0.15, height: 1)
        let cylinderShape = SCNPhysicsShape(geometry: cylinder, options: nil)
        return SCNPhysicsBody(type: .dynamic, shape: cylinderShape)
    }
    
}
