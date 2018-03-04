//
//  BallThrowingStateController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class BallThrowingStateController: GameStateController {
    
    var canThrow = true
    
    func setup() {
        game.cameraPreviousPosition = nil
        game.cameraCurrentPosition = game.camera?.transform.position
    }
    
    func teardown() {
    }
    
    func update(at time: TimeInterval) {
        game.cameraPreviousPosition = game.cameraCurrentPosition
        game.cameraCurrentPosition = game.camera?.transform.position
        
        game.previousTime = game.currentTime
        game.currentTime = time
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canThrow else { return }
        game.showBallPlaceholder()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canThrow else { return }
//        canThrow = false
        game.throwBall()
    }
}
