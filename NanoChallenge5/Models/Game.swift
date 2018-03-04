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
    
    static let shared = Game()
    private override init() {}
    
    weak var sceneView: ARSCNView!
    var viewCenter: CGPoint!
    
    // entities
    var ballPlaceholder: SCNNode!
    var pins: SCNNode!
    
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
        return position + direction * Constants.game.spawnDepth
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
        // node
        let floor = SCNBox(width: 1000, height: 10, length: 1000, chamferRadius: 0)
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = pins.position
        floorNode.position.y -= Float(floor.height / 2)
        floorNode.opacity = 0
        sceneView.scene.rootNode.addChildNode(floorNode)
        
        // physics
//        let floorShape = SCNPhysicsShape(geometry: floor, options: nil)
        floorNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        floorNode.physicsBody?.restitution = 0.4
    }
    
    func enablePhysics() {
        for pin in pins.childNodes {
            pin.physicsBody = pinPhysicsBody()
        }
    }
    
    private func pinPhysicsBody() -> SCNPhysicsBody {
        let cylinder = SCNCylinder(radius: 0.15, height: 1)
        let cylinderShape = SCNPhysicsShape(geometry: cylinder, options: nil)
        return SCNPhysicsBody(type: .dynamic, shape: cylinderShape)
    }
    
    func showBallPlaceholder() {
        ballPlaceholder.runAction(SCNAction.fadeIn(duration: Constants.fx.placeholderFadeDuration))
    }
    
    func hideBallPlaceholder() {
        ballPlaceholder.removeAllActions()
        ballPlaceholder.opacity = 0
    }
    
    func throwBall() {
        hideBallPlaceholder()
        
        let velocity = cameraVelocity * Constants.game.throwingIntensity
        let ball = Ball.create(at: spawnPoint, withVelocity: velocity)
        sceneView.scene.rootNode.addChildNode(ball)
    }
}
