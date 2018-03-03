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
        print(">>> State: NewGameState")
        game.sceneView.showsStatistics = false
//        game.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        game.sceneView.autoenablesDefaultLighting = true
        game.sceneView.scene = SCNScene()
        
        loadModels(game: game)
    }
    
    func teardown(game: Game) {
        print("<<< State: NewGameState")
    }
    
    func update(game: Game) {
    }
    
    func loadModels(game: Game) {
        let pinsScene = SCNScene(named: "art.scnassets/ball.dae")!
        game.ball = pinsScene.rootNode
        game.ball!.isHidden = true
        game.sceneView.scene.rootNode.addChildNode(game.ball!)
    }
}
