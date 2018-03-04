//
//  NewGameState.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 01/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import ARKit

struct NewGameState: GameState {
    
    func setup(game: Game) {
        game.sceneView.autoenablesDefaultLighting = true
        game.scene = SCNScene()
        game.pins = loadPins(into: game.scene.rootNode)
        game.ballPlaceholder = createBallPlaceholder(game: game)
    }
    
    func teardown(game: Game) {}
    
    func update(game: Game, at time: TimeInterval) {}
    
    private func loadPins(into node: SCNNode) -> SCNNode {
        let pins = SCNScene(named: Constants.models.pins)!.rootNode
        pins.isHidden = true
        pins.position = SCNVector3Make(0, -1, -5)
        node.addChildNode(pins)
        return pins
    }
    
    private func createBallPlaceholder(game: Game) -> SCNNode? {
        guard let pointOfView = game.sceneView.pointOfView else { return nil }
        let node = Ball.create().childNodes.first!.clone()
        node.position = pointOfView.position + SCNVector3(0, 0, -1)
        node.opacity = 0
        pointOfView.addChildNode(node)
        return node
    }
}
