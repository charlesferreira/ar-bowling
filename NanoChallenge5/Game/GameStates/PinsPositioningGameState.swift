//
//  PinsPositioningGameState.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import ARKit

struct PinsPositioningGameState: GameState {
    
    func setup(game: Game) {}
    
    func teardown(game: Game) {
        game.createFloorNode()
        game.enablePhysics()
    }
    
    func update(game: Game) {
        guard let view = game.sceneView else { return }
        
        let hits = view.hitTest(game.viewCenter, types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane])
        if let position = hits.last?.worldTransform.position {
            game.pins!.isHidden = false
            game.pins!.position = position
        }
    }
}
