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
    
    // singleton
    static let shared = Game()
    private init() {}
    
    // view
    weak var sceneView: ARSCNView!
    var viewCenter: CGPoint!
    
    // entities
    var ball: SCNNode!
    var pins: SCNNode!
    
    // convenience accessor
    var scene: SCNScene {
        get { return sceneView.scene }
        set { sceneView.scene = newValue }
    }
    
    // máquina de estados
    var state: GameState? {
        didSet {
            oldValue?.teardown(game: self)
            state?.setup(game: self)
        }
    }
    
    // câmera
    var cameraPreviousPosition: SCNVector3?
    var cameraCurrentPosition: SCNVector3?
    var camera: ARCamera? {
        return sceneView.session.currentFrame?.camera
    }
    
    func setup(sceneView: ARSCNView) {
        self.sceneView = sceneView
        sceneView.debugOptions = [.showPhysicsShapes]
        self.viewCenter = sceneView.center
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
    
    func createFloorNode() {
        // node
        let floor = SCNBox(width: 1000, height: 10, length: 1000, chamferRadius: 0.5)
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = pins.position
        floorNode.position.y -= Float(floor.height / 2)
        floorNode.opacity = 0
        scene.rootNode.addChildNode(floorNode)
        
        // physics
        let floorShape = SCNPhysicsShape(geometry: floor, options: nil)
        floorNode.physicsBody = SCNPhysicsBody(type: .static, shape: floorShape)
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
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: cylinderShape)
        physicsBody.mass = 1
        physicsBody.restitution = 0.5
        physicsBody.friction = 0.7
        physicsBody.damping = 0.2
        
        return physicsBody
    }
    
    func throwBall() {
        // node
        let position = sceneView.pointOfView!.position
        let direction = sceneView.pointOfView!.direction
        ball.position = position + direction
        scene.rootNode.addChildNode(ball)
        
        // física
        ball.physicsBody = ballPhysicsBody()
        ball.physicsBody!.velocity = direction * 8.0
    }
    
    private func ballPhysicsBody() -> SCNPhysicsBody {
        let sphere = SCNSphere(radius: 0.25)
        let sphereShape = SCNPhysicsShape(geometry: sphere, options: nil)
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: sphereShape)
        physicsBody.mass = 10
        physicsBody.restitution = 0.8
        physicsBody.friction = 0.5
        physicsBody.damping = 0.0
        
        return physicsBody
    }
}
