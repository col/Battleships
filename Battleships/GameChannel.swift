//
//  GameChannel.swift
//  Battleships
//
//  Created by Colin Harris on 6/4/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import Foundation
import Birdsong

protocol GameChannelDelegate {
    func playerJoined()
    func playerSetShips()
}

class GameChannel {
    
    let socket: Socket
    var channel: Channel!
    
    let player: String
    
    var delegate: GameChannelDelegate?
    
    init(socket: Socket, name: String, player: String) {
        self.socket = socket
        self.player = player
        channel = self.socket.channel(name, payload: [:])
            
        channel.on("player_added", callback: { message in
            print("Player added!")
            self.delegate?.playerJoined()
        })
        
        channel.on("player_set_ships", callback: { message in
            print("Player set ships!")
            self.delegate?.playerSetShips()
        })
        
        channel.join()?.receive("ok", callback: { payload in
            print("Successfully joined: \(self.channel.topic)")
        })
    }
    
    func guessCoordinate(coordinate: String) {
        print("guess_coordinate - \(["player": player, "coordinate": coordinate])")
        channel.send("guess_coordinate", payload: ["player": player, "coordinate": coordinate])?
            .receive("ok", callback: { (response) in
                print("response = \(response)")
            })
            .receive("error", callback: { (response) in
                print("error = \(response)")
            })
    }
    
    func setShip(ship: String, coordinates: [String]) {
        channel.send("set_ship_coordinates", payload: ["player": player, "ship": ship, "coordinates": coordinates])?
            .receive("ok", callback: { (response) in
                print("response = \(response)")
            })
            .receive("error", callback: { (response) in
                print("error = \(response)")
            })
    }
    
    func setShips(player: String) {
        channel.send("set_ships", payload: ["player": player])?
            .receive("ok", callback: { (response) in
                print("response = \(response)")
            })
            .receive("error", callback: { (response) in
                print("error = \(response)")
            })
    }
}
