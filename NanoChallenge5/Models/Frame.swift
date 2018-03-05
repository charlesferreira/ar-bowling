//
//  Frame.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 04/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

class Frame {
    
    let number: Int
    
    private (set) var rolls = [Roll]()
    private (set) var score: Int?
    private (set) var ballIndex = 0
    
    var firstBall: Roll? { return rollForBall(atIndex: 0) }
    var secondBall: Roll? { return rollForBall(atIndex: 1) }
    var thirdBall: Roll? { return rollForBall(atIndex: 2) }
    
    private var maxRolls: Int {
        return number == Constants.Game.numberOfFrames ? 3 : 2
    }
    
    var ballsLeft: Int {
        return maxRolls - (ballIndex + 1)
    }
    
    var hasLeftOver: Bool {
        guard let lastRoll = rolls.last else { return true }
        switch lastRoll.type {
        case .open(_):
            return true
        default:
            return false
        }
    }
    
    var isComplete: Bool {
        return ballsLeft == 0 || !hasLeftOver
    }
    
    init(number: Int) {
        self.number = number
    }
    
    func roll(pins: Int) {
        rolls.append(Roll(type: .strike, frame: self))
        ballIndex += 1
    }
    
    private func rollForBall(atIndex index: Int) -> Roll? {
        guard rolls.indices.contains(index) else { return nil }
        
        return rolls[index]
    }
    
}
