//
//  Ball.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 28/02/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class Ball: SCNNode {
    
    private static let shared = Ball(model: SCNScene(named: Constants.Models.ball)!.rootNode)
    
    static func create() -> Ball {
        return shared.clone()
    }
    
    static func create(position: SCNVector3, velocity: SCNVector3) -> Ball {
        let ball = create()
        ball.position = position
        ball.physicsBody!.velocity = velocity
        return ball
    }
    
    private convenience init(model: SCNNode) {
        self.init()
        addChildNode(model)
        addPhysicsBody()
        scheduleRemoval()
    }
    
    private override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func scheduleRemoval() {
        let delay = delayAction()
        let fadeOut = fadeOutAction()
        let remove = removeAction()
        runAction(SCNAction.sequence([delay, fadeOut, remove]))
    }
    
    private func delayAction() -> SCNAction {
        return SCNAction.wait(duration: Constants.Game.ballLifeTime)
    }
    
    private func fadeOutAction() -> SCNAction {
        return SCNAction.fadeOut(duration: Constants.FX.ballFadeOutDuration)
    }
    
    private func removeAction() -> SCNAction {
        return SCNAction.run { node in
            node.removeFromParentNode()
        }
    }
    
    private func addPhysicsBody() {
        let sphere = SCNSphere(radius: 0.2)
        let sphereShape = SCNPhysicsShape(geometry: sphere, options: nil)
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: sphereShape)
        physicsBody!.mass = 10
        physicsBody!.restitution = 0.8
        physicsBody!.friction = 0.3
        physicsBody!.damping = 0.0
    }
}
