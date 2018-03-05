//
//  ARViewController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 28/02/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit
import ARKit

class ARViewController: BaseViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        Game.instance.setup(sceneView: sceneView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Game.instance.resume()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Game.instance.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        performSegue(withIdentifier: "ShowTitle", sender: self)
//        performSegue(withIdentifier: "ScoreboardDemo", sender: self)
    }
}

extension ARViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        Game.instance.update(at: time)
    }
}
