//
//  BattleshipSocket.swift
//  Battleships
//
//  Created by Colin Harris on 8/4/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import Foundation
import Birdsong

class BattleshipSocket {
    
    let socket: Socket
    
    init() {
        socket = Socket(url: URL(string: "http://192.168.0.166:4000/socket/websocket")!)
    }
    
    func connect(callback: @escaping () -> Void) {
        socket.onConnect = {
            print("Socket connected")
            callback()
        }
        socket.connect()
    }
    
    func lobby() -> LobbyChannel {
        let channel = LobbyChannel(socket: self.socket)
        channel.join()
        return channel
    }        
    
}
