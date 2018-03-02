//
//  TitleViewController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 01/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class TitleViewController: BaseViewController {
    
    @IBOutlet weak var charlesLabel: UILabel!
    
    override func viewDidLoad() {
        charlesLabel.transform = charlesLabel.transform.rotated(by: -7 * .pi / 180)
    }
    
    @IBAction func backToTitle(unwindSegue: UIStoryboardSegue) {}
}
