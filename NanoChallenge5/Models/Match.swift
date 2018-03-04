//
//  Match.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

class Match {
    
    static let instance = Match()
    
    private (set) var players = [Player()]
    
    private init() {}
    
    func addPlayer(_ player: Player) {
        players.append(player)
    }
    
    func removePlayer(_ player: Player) {
        players = players.filter { $0 !== player }
    }
    
    func movePlayer(fromIndex oldIndex: Int, toIndex newIndex: Int) {
        let player = players.remove(at: oldIndex)
        players.insert(player, at: newIndex)
    }
    
    func resetScore() {
        for player in players {
            player.score = 0
        }
    }
}