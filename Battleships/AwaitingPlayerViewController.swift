//
//  AwaitingPlayerViewController.swift
//  Battleships
//
//  Created by Colin Harris on 8/4/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class AwaitingPlayerViewController: UIViewController, GameChannelDelegate {
    
    var gameChannel: GameChannel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameChannel?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SetShips" {
            let controller = segue.destination as? SetShipsViewController
            controller?.gameChannel = gameChannel
        }
    }
    
    func playerJoined() {
        print("Player Joined!")
        self.performSegue(withIdentifier: "SetShips", sender: self)
    }
    
    func playerSetShips() {
        print("Player Set Ships")
    }
    
}
