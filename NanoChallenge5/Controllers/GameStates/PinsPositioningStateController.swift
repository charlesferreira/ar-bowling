//
//  PinsPositioningStateController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class PinsPositioningStateController: GameStateController {

    func setup() {
        game.sceneView.autoenablesDefaultLighting = true
        game.sceneView.scene = SCNScene()
        game.pins = loadPins()
        game.ballPlaceholder = createBallPlaceholder()
    }
    
    func teardown() {
        game.createFloorNode()
        game.enablePhysics()
    }
    
    func update(at time: TimeInterval) {
        guard let view = game.sceneView else { return }
        
        let hits = view.hitTest(game.viewCenter, types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane])
        if let position = hits.last?.worldTransform.position {
            game.pins!.position = position + SCNVector3(0, -0.3, 0)
        }
    }
    
    private func loadPins() -> SCNNode {
        let pins = SCNScene(named: Constants.models.pins)!.rootNode
        pins.position = game.sceneView.pointOfView!.direction + SCNVector3Make(0, -1, -5)
        game.sceneView.scene.rootNode.addChildNode(pins)
        return pins
    }
    
    private func createBallPlaceholder() -> SCNNode? {
        guard let pointOfView = game.sceneView.pointOfView else { return nil }
        let node = Ball.create().childNodes.first!.clone()
        node.position = pointOfView.position + SCNVector3(0, 0, -1)
        node.opacity = 0
        pointOfView.addChildNode(node)
        return node
    }
}
