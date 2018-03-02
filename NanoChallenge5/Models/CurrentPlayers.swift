//
//  CurrentPlayers.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

class CurrentPlayers {
    
    static let shared = CurrentPlayers()
    
    private (set) var players = [Player()]
    
    static var count: Int {
        return shared.players.count
    }
    
    private init() {}
    
    func addPlayer(_ player: Player) {
        players.append(player)
    }
    
    func removePlayer(_ player: Player) {
        players = players.filter { $0 !== player }
    }
    
    func resetScore() {
        for player in players {
            player.score = 0
        }
    }
}
