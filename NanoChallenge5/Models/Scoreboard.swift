//
//  Scoreboard.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

class Scoreboard {
    
    var players = [Player(),Player(),Player(),Player()]
    var frames = [[Frame]]()
    
    var playerIndex = 0
    var frameIndex = 0
    
    var isLastFrame: Bool {
        return playerIndex == players.endIndex && frameIndex == Constants.Game.numberOfFrames - 1
    }
    
    var currentFrame: Frame {
        return frames[playerIndex][frameIndex]
    }
    
    func setUp() {
        playerIndex = 0
        frameIndex = 0
        resetFrames()
    }
    
    func resetFrames() {
        let playerFrames = [Frame](repeating: Frame(), count: Constants.Game.numberOfFrames)
        frames = [[Frame]](repeating: playerFrames, count: players.count)
    }
    
    func score(pins: Int) -> ThrowResults {
        currentFrame.score(pins: pins)
        
        return currentFrame.isComplete ? nextFrame() : nextBall()
    }
    
    private func nextFrame() -> ThrowResults {
        guard !isLastFrame else { return .gameOver }
        
//        frameIndex = (frameIndex + 1) % Constants.Game.numberOfFrames
//        playerIndex = (playerIndex + 1) % players.count
        return .frameComplete
    }
    
    private func nextBall() -> ThrowResults {
        return .nextBall
    }
}
