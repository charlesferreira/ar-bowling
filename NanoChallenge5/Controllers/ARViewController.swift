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
        ARManager.configure(sceneView: sceneView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ARManager.shared.resume()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ARManager.shared.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        performSegue(withIdentifier: "ShowTitle", sender: self)
    }
}
