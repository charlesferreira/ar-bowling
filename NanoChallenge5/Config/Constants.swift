//
//  Constants.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import Foundation

struct Constants {
    
    static let player = Player()
    static let game = Game()
    static let userDefaults = UserDefaults()
    static let models = Models()
    static let fx = FX()
    
    private init() {}
}

extension Constants {
    
    struct Player {
        let nameMaxLength = 15
    }
    
    struct Game {
        let minPlayers = 1
        let maxPlayers = 4
        let ballLifeTime = 5.0
        // distância entre a câmera e o ponto de surgimento das bolas
        let spawnDepth = 1.0
        // multiplicador de velocidade da câmera pra um arremesso mais legal
        let throwingIntensity = 1.5
    }
    
    struct UserDefaults {
        let keyForHighscores = "highscores"
    }
    
    struct Models {
        let ball = "art.scnassets/ball.scn"
        let pins = "art.scnassets/pins.scn"
    }
    
    struct FX {
        let placeholderFadeDuration = 0.1
        let ballFadeOutDuration = 1.0
    }
}
