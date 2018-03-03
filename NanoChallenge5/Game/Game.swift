//
//  Game.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit
import ARKit

class Game {
    
    static let shared = Game()
    
    weak var sceneView: ARSCNView!
    
    var ball: SCNNode?
    
    var state: GameState? {
        didSet {
            oldValue?.teardown(game: self)
            state?.setup(game: self)
        }
    }
    
    private var camera: ARCamera? {
        return sceneView.session.currentFrame?.camera
    }
    
    private init() {}
    
    func setup(sceneView: ARSCNView) {
        self.sceneView = sceneView
        state = NewGameState()
    }
    
    func resume() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    func pause() {
        sceneView.session.pause()
    }
    
    func update() {
        state?.update(game: self)
    }
}
