//
//  HighscoresViewController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class HighscoresViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var defaults: UserDefaults = .standard
    
    var highscores = [[String: Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHighscores()
    }
    
    private func loadHighscores() {
        highscores = defaults.array(forKey: Constants.userDefaults.keyForHighscores) as! [[String : Int]]
    }
}

extension HighscoresViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoreTableViewCell") as? HighscoreTableViewCell else {
            fatalError("Célula não encontrada")
        }
        
        if let highscore = highscores[indexPath.row].first {
            cell.highscore = (player: highscore.key, score: highscore.value)
        }
        
        return cell
    }
}
