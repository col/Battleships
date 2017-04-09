//
//  JoinGameViewController.swift
//  Battleships
//
//  Created by Colin Harris on 8/4/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class JoinGameViewController: UITableViewController {
    
    var gameChannel: GameChannel?
    var lobbyChannel: LobbyChannel?
    var games: [[String: String]] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lobbyChannel?.openGames() { games in
            self.games = games
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = games[indexPath.row]["name"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt: \(indexPath)")
        let game = games[indexPath.row]["game"]
        lobbyChannel?.joinGame(game: game!, name: "Col") { gameChannel in
            self.gameChannel = gameChannel
            self.performSegue(withIdentifier: "SetShips", sender: self)
        }        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SetShips" {
            let controller = segue.destination as! SetShipsViewController
            controller.gameChannel = gameChannel
        }
    }
}
