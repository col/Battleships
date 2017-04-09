//
//  SetShipsViewController.swift
//  Battleships
//
//  Created by Colin Harris on 8/4/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class SetShipsViewController: UIViewController, GridViewDelegate {
    
    @IBOutlet var gridView: UIView!
    @IBOutlet var gridViewController: GridViewController!
    
    var gameChannel: GameChannel!
    
    var aircraftCarrier: ShipView?
    var battleship: ShipView?
    var cruiser: ShipView?
    var submarine: ShipView?
    var destroyer: ShipView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.tag = 1
        
        gridViewController = self.childViewControllers.first as! GridViewController
        gridViewController.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        gridViewController.automaticallyAdjustsScrollViewInsets = false
        
        aircraftCarrier = ShipView(frame: CGRect(x: 3, y: 3, width: 27, height: 147))
        gridView.addSubview(aircraftCarrier!)
        
        battleship = ShipView(frame: CGRect(x: 33, y: 3, width: 27, height: 117))
        gridView.addSubview(battleship!)
        
        cruiser = ShipView(frame: CGRect(x: 63, y: 3, width: 27, height: 87))
        gridView.addSubview(cruiser!)
        
        submarine = ShipView(frame: CGRect(x: 93, y: 3, width: 27, height: 87))
        gridView.addSubview(submarine!)
        
        destroyer = ShipView(frame: CGRect(x: 123, y: 3, width: 27, height: 57))
        gridView.addSubview(destroyer!)
    }
    
    @IBAction
    func setShips() {
        gameChannel.setShip(ship: "aircraft_carrier", coordinates: ["a1", "b1", "c1", "d1", "e1"])
        gameChannel.setShip(ship: "batteship", coordinates: ["a2", "b2", "c2", "d2"])
        gameChannel.setShip(ship: "cruiser", coordinates: ["a3", "b3", "c3"])
        gameChannel.setShip(ship: "submarine", coordinates: ["a4", "b4", "c4"])
        gameChannel.setShip(ship: "destroyer", coordinates: ["a5", "b5"])
        
        gameChannel.setShips(player: "player1")
        
        self.performSegue(withIdentifier: "Game", sender: self)
    }
    
    func gridView(didSelectCoordinate coordinate: String) {
        // TODO: disable grid selection and make this callback optional
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Game" {
            let controller = segue.destination as? GameViewController
            controller?.gameChannel = gameChannel
        }
    }
}
