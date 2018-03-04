//
//  BallThrowingGameState.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 03/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

struct BallThrowingGameState: GameState {
    
    func setup(game: Game) {
        game.cameraPreviousPosition = nil
        game.cameraCurrentPosition = game.camera?.transform.position
    }
    
    func teardown(game: Game) {
    }
    
    func update(game: Game) {
        game.cameraPreviousPosition = game.cameraCurrentPosition
        game.cameraCurrentPosition = game.camera?.transform.position
    }
}

