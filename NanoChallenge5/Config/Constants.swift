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
    
    private init() {}
}

extension Constants {
    
    struct Player {
        let nameMaxLength = 15
    }
    
    struct Game {
        let maxPlayers = 4
    }
    
}
