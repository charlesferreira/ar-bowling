//
//  PinsPositioningGameState.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import ARKit

struct PinsPositioningGameState: GameState {
    
    func setup(game: Game) {
        print(">>> State: PinsPositioningGameState")
    }
    
    func teardown(game: Game) {
        print("<<< State: PinsPositioningGameState")
    }
    
    func update(game: Game) {
        guard let sceneView = game.sceneView else { return }
        
        DispatchQueue.main.async {
            let hits = sceneView.hitTest(sceneView.center, types: [.existingPlane])
            if let position = hits.first?.worldTransform.position {
                game.ball?.isHidden = false
                game.ball?.position = position
            }
        }
    }
}
