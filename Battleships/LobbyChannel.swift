//
//  LobbyChannel.swift
//  Battleships
//
//  Created by Colin Harris on 8/4/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import Foundation
import Birdsong

protocol LobbyChannelDelegate {
    func gameAdded()
    func gameRemoved()
}

class LobbyChannel {
    
    let socket: Socket!
    let channel: Channel!
    var delegate: LobbyChannelDelegate?
    
    init(socket: Socket) {
        self.socket = socket
        self.channel = socket.channel("lobby", payload: [:])
    }
    
    func join() {
        channel.on("game_added", callback: { message in
            self.delegate?.gameAdded()
        })
        
        channel.on("game_removed", callback: { message in
            self.delegate?.gameRemoved()
        })
        
        channel.join()?.receive("ok", callback: { payload in
            print("Successfully joined: \(self.channel.topic)")
        })
    }
    
    func openGames(callback: @escaping ([[String: String]]) -> Void) {
        channel.send("open_games", payload: [:])?
            .receive("ok", callback: { (response) in
                print("response = \(response)")
                let data = response["response"] as! [String: Any]
                callback(data["games"] as! [[String: String]])
            })
            .receive("error", callback: { (response) in
                print("error = \(response)")
                callback([])
            })
    }
    
    func newGame(name: String, callback: @escaping (GameChannel?) -> Void) {
        print("Sending 'new_game' - \(["player": name])")
        channel.send("new_game", payload: ["player": name])?
            .receive("ok", callback: { (response) in
                print("response = \(response)")
                let data = response["response"] as! [String: Any]
                callback(self.joinGameChannel(game: data["game"] as! String, player: "player1"))
            })
            .receive("error", callback: { (response) in
                print("error = \(response)")
                callback(nil)
            })
    }
    
    func joinGame(game: String, name: String, callback: @escaping (GameChannel?) -> Void) {
        channel.send("join_game", payload: ["game": game, "player": name])?
            .receive("ok", callback: { (response) in
                print("response = \(response)")
                callback(self.joinGameChannel(game: game, player: "player2"))
            })
            .receive("error", callback: { (response) in
                print("error = \(response)")
                callback(nil)
            })
    }
    
    func joinGameChannel(game: String, player: String) -> GameChannel {
        return GameChannel(socket: socket, name: game, player: player)
    }
    
}
