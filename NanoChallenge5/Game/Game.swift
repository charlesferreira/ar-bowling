//
//  Game.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 28/02/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class Game {
    
    func launchBall(from position: SCNVector3) -> SCNNode {
        let ballGeometry = SCNSphere(radius: 0.02)
        let ballNode = SCNNode(geometry: ballGeometry)
        ballNode.position = position + SCNVector3Make(0, 0, -0.2)
        return ballNode
    }
    
}
