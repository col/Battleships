//
//  NewGameViewController.swift
//  Battleships
//
//  Created by Colin Harris on 8/4/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var playerNameField: UITextField!
    
    var gameChannel: GameChannel?
    var lobbyChannel: LobbyChannel?
    
    @IBAction
    func continueClicked() {
        print("continueClicked")
        lobbyChannel?.newGame(name: playerNameField.text!) { gameChannel in
            self.gameChannel = gameChannel
            self.performSegue(withIdentifier: "AwaitingPlayer", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AwaitingPlayer" {
            let controller = segue.destination as? AwaitingPlayerViewController
            controller?.gameChannel = gameChannel
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        continueClicked()
        return true
    }
    
}
