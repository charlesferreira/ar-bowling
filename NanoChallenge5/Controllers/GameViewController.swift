//
//  GameViewController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 28/02/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class GameViewController: BaseViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    private var game = Game()

    private var camera: ARCamera? {
        return sceneView.session.currentFrame?.camera
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        performSegue(withIdentifier: "ShowTitle", sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let camera = camera else { return }
        let position = camera.transform.position
        let ball = game.launchBall(from: position)
        sceneView.scene.rootNode.addChildNode(ball)
    }
    
    private func setupSceneView() {
        sceneView.delegate = self
        sceneView.showsStatistics = false
        sceneView.scene = SCNScene(named: "art.scnassets/game.scn")!
    }
    private func setupSession() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
}
