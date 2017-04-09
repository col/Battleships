//
//  MainViewController.swift
//  Battleships
//
//  Created by Colin Harris on 8/4/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var socket: BattleshipSocket?
    var lobbyChannel: LobbyChannel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.socket = BattleshipSocket()
        self.socket?.connect() {
            self.lobbyChannel = self.socket?.lobby()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewGame" {
            let controller = segue.destination as? NewGameViewController
            controller?.lobbyChannel = lobbyChannel
        }
        
        if segue.identifier == "JoinGame" {
            let controller = segue.destination as? JoinGameViewController
            controller?.lobbyChannel = lobbyChannel
        }
    }
    
}
