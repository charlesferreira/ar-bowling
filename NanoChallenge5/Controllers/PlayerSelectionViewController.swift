//
//  PlayerSelectionViewController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class PlayerSelectionViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAddButton()
        setupTapGesture()
        tableView.isEditing = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismissKeyboard()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        CurrentPlayers.shared.addPlayer(Player())
        updateAddButton()
        tableView.reloadData()
    }
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(tap)
    }
    
    private func updateAddButton() {
        addButton.isHidden = CurrentPlayers.count >= Constants.game.maxPlayers
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension PlayerSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell") as? PlayerTableViewCell else {
            fatalError("Célula não encontrada")
        }

        cell.delegate = self
        cell.player = CurrentPlayers.shared.players[indexPath.row]
        
        return cell
    }
}

extension PlayerSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}


extension PlayerSelectionViewController: PlayerTableViewCellDelegate {
    
    func cell(_ cell: PlayerTableViewCell, didRemovePlayer player: Player) {
        CurrentPlayers.shared.removePlayer(player)
        tableView.reloadData()
    }
}
