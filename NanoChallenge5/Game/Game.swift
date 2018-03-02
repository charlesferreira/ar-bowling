//
//  Game.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 28/02/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class Game {
    
    var arrow: Arrow?
    
    var state: GameState? {
        didSet {
            oldValue?.teardown()
            state?.setup()
        }
    }
    
    init () {
        state = NewGameState()
    }
    
    func update(atTime: TimeInterval) {
        state?.update(self)
    }
    
}
