//
//  GameResultsStateController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class ScoreboardStateController: GameStateController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        
    }
}

extension ScoreboardStateController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.scoreboard.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreboardTableViewCell") as? ScoreboardTableViewCell else {
            fatalError("Erro ao obter célula: ScoreboardTableViewCell")
        }
        
        cell.playerIndex = indexPath.row
        
        return cell
    }
    
}