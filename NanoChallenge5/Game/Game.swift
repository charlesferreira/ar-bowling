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
    
    var viewCenter: CGPoint!
    //var ball: SCNNode!
    var pins: SCNNode!
    
    // convenience accessor
    var scene: SCNScene {
        get { return sceneView.scene }
        set { sceneView.scene = newValue }
    }
    
    var state: GameState? {
        didSet {
            oldValue?.teardown(game: self)
            state?.setup(game: self)
        }
    }
    
    var camera: ARCamera? {
        return sceneView.session.currentFrame?.camera
    }
    
    private init() {}
    
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
        let floor = SCNBox(width: 10, height: 1, length: 10, chamferRadius: 0.5)
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = pins.position
        floorNode.position.y -= Float(floor.height / 2)
//        floorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
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
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        physicsBody.mass = 3
        physicsBody.restitution = 0.5
        physicsBody.friction = 0.7
        physicsBody.damping = 0.2
        
        return physicsBody
    }
}
