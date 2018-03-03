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
        game.sceneView.showsStatistics = false
//        game.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        game.sceneView.autoenablesDefaultLighting = true
        game.sceneView.scene = SCNScene()
        
        loadModelsAsync(game: game)
    }
    
    func teardown(game: Game) {
    }
    
    func update(game: Game) {
    }
    
    func loadModelsAsync(game: Game) {
        DispatchQueue.global(qos: .userInitiated).async {
            let pinsScene = SCNScene(named: "art.scnassets/ball.dae")!
            game.ball = pinsScene.rootNode
            game.ball!.isHidden = true
            game.sceneView.scene.rootNode.addChildNode(game.ball!)
        }
    }
}
