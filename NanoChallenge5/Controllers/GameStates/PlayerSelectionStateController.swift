//
//  PlayerSelectionViewController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class PlayerSelectionStateController: GameStateController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    private var match: Match { return game.match }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtons()
        setupTapGesture()
        tableView.isEditing = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismissKeyboard()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        match.addPlayer(Player())
        updateButtons()
        tableView.reloadData()
    }
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(tap)
    }
    
    private func updateButtons() {
        let numberOfPlayers = match.players.count
        addButton.isHidden = numberOfPlayers >= Constants.Game.maxPlayers
        
        let namedPlayers = match.players.filter { !$0.name.isEmpty }.count
        startButton.isEnabled = numberOfPlayers == namedPlayers && namedPlayers > 0
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        updateButtons()
    }
    
    @IBAction func backToPlayerSelection(unwindSegue: UIStoryboardSegue) {}
}

extension PlayerSelectionStateController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return match.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell") as? PlayerTableViewCell else {
            fatalError("Célula não encontrada")
        }

        cell.delegate = self
        cell.player = match.players[indexPath.row]
        
        return cell
    }
}

extension PlayerSelectionStateController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        match.movePlayer(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}


extension PlayerSelectionStateController: PlayerTableViewCellDelegate {
    
    func cell(_ cell: PlayerTableViewCell, didRemovePlayer player: Player) {
        match.removePlayer(player)
        updateButtons()
        tableView.reloadData()
    }
}
