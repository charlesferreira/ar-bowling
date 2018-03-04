//
//  Game.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit
import ARKit

@objc class Game: NSObject {
    
    static let instance = Game()
    private override init() {}
    
    weak var sceneView: ARSCNView!
    var viewCenter: CGPoint!
    
    // entities
    var pinsPlaceholder: SCNNode!
    var ballPlaceholder: SCNNode!
    
    var state: GameState? {
        willSet {
            state?.teardown?()
            newValue?.setup?()
        }
    }
    
    // câmera
    var cameraPreviousPosition: SCNVector3?
    var cameraCurrentPosition: SCNVector3!
    var camera: ARCamera? {
        return sceneView.session.currentFrame?.camera
    }
    var cameraTranslation: SCNVector3 {
        guard let previousPosition = cameraPreviousPosition else { return SCNVector3Zero }
        return cameraCurrentPosition - previousPosition
    }
    var cameraVelocity: SCNVector3 {
        guard deltaTime != nil else { return SCNVector3Zero }
        return cameraTranslation / Float(deltaTime!)
    }
    
    // delta time
    var previousTime: TimeInterval?
    var currentTime: TimeInterval!
    var deltaTime: TimeInterval? {
        guard previousTime != nil else { return nil }
        return currentTime - previousTime!
    }
    
    // spawn
    var spawnPoint: SCNVector3 {
        let position = sceneView.pointOfView!.position
        let direction = sceneView.pointOfView!.direction
        return position + direction * Constants.Game.spawnDepth
    }
    
    func setup(sceneView: ARSCNView) {
        sceneView.debugOptions = [.showPhysicsShapes]
        self.sceneView = sceneView
        self.viewCenter = sceneView.center
    }
    
    func resume() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    func pause() {
        sceneView.session.pause()
    }
    
    func update(at time: TimeInterval) {
        state?.update?(at: time)
    }
    
    func createFloorNode() {
        let floorNode = Floor(at: pinsPlaceholder.position)
        sceneView.scene.rootNode.addChildNode(floorNode)
    }
    
    func showBallPlaceholder() {
        ballPlaceholder.runAction(SCNAction.fadeIn(duration: Constants.FX.placeholderFadeDuration))
    }
    
    func hideBallPlaceholder() {
        ballPlaceholder.removeAllActions()
        ballPlaceholder.opacity = 0
    }
    
    func throwBall() {
        hideBallPlaceholder()
        
        let velocity = cameraVelocity * Constants.Game.throwingIntensity
        let ball = Ball.create(position: spawnPoint, velocity: velocity)
        sceneView.scene.rootNode.addChildNode(ball)
    }
}
