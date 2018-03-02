//
//  ARManager.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit
import ARKit

class ARManager {
    
    static let shared = ARManager()
    
    private weak var sceneView: ARSCNView!
    
    private var camera: ARCamera? {
        return sceneView.session.currentFrame?.camera
    }
    
    private init() {}
    
    static func configure(sceneView: ARSCNView) {
        sceneView.showsStatistics = false
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        sceneView.scene = SCNScene(named: "art.scnassets/game.scn")!
        shared.sceneView = sceneView
    }
    
    func resume() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    func pause() {
        sceneView.session.pause()
    }
}
