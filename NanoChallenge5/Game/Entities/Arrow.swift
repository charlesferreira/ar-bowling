//
//  Arrow.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 01/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class Arrow {
    
    var sceneNode: SCNNode
    
    var target: SCNNode?
    
    init(position: SCNVector3) {
        let scene = SCNScene(named: "art.scnassets/arrow.dae")!
        sceneNode = scene.rootNode.childNode(withName: "Arrow", recursively: false)!
        sceneNode.position = position
    }
    
//    func update() {
//        guard let target = target else { return }
//
//        let dir = Math.calculateCameraDirection(cameraNode: self.camera)
//        let pos = pointInFrontOfPoint(point: self.camera.position, direction:dir, distance: 18)
//        rectnode.position = pos
//        rectnode.orientation = self.camera.orientation
//    }

    
//    private func setupTrackingArrow() {
//        guard let camera = camera else { return }
//        let position = camera.transform.position + SCNVector3Make(0, 0, -0.5)
//        TrackingArrow(position: position, target: sceneView.scene.rootNode)
//        let arrow = game.arrow.sceneNode
//        sceneView.pointOfView?.addChildNode(arrow.sceneNode)
//    }
    
    
}
