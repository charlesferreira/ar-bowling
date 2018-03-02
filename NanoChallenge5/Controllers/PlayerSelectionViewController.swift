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
    
    var players = [Player()] {
        didSet {
            updateAddButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(tap)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismissKeyboard()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        players.append(Player())
        tableView.reloadData()
    }
    
    private func updateAddButton() {
        addButton.isHidden = players.count >= Constants.game.maxPlayers
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension PlayerSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell") as? PlayerTableViewCell else {
            fatalError("Célula não encontrada")
        }

        cell.delegate = self
        cell.player = players[indexPath.row]
        
        return cell
    }
}

extension PlayerSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
}


extension PlayerSelectionViewController: PlayerTableViewCellDelegate {
    
    func cell(_ cell: PlayerTableViewCell, didRemovePlayer player: Player) {
        players = players.filter { $0 !== player }
        tableView.reloadData()
    }
}
