//
//  GameState.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 01/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

protocol GameState {
    
    func setup()
    
    func teardown()
    
    func update(_ game: Game)
}
