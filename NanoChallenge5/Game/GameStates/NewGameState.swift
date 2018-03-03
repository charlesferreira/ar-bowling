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
//        game.sceneView.showsStatistics = false
        game.sceneView.autoenablesDefaultLighting = true
        game.scene = SCNScene()
        game.pins = loadPins(into: game.scene.rootNode)
    }
    
    func teardown(game: Game) {}
    
    func update(game: Game) {}
    
    private func loadPins(into node: SCNNode) -> SCNNode {
        let pins = SCNScene(named: "art.scnassets/pins.scn")!.rootNode
        pins.position = SCNVector3Make(0, -0.5, -5)
        node.addChildNode(pins)
        return pins
    }
}
