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
    
    private init() {}
}

extension Constants {
    
    struct Player {
        let nameMaxLength = 15
    }
    
    struct Game {
        let minPlayers = 1
        let maxPlayers = 4
    }
    
    struct UserDefaults {
        let keyForHighscores = "highscores"
    }
    
}
