//
//  PinsPositioningViewController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class PinsPositioningViewController: BaseViewController {

    override func viewDidLoad() {
        Game.shared.state = PinsPositioningGameState()
    }
}
