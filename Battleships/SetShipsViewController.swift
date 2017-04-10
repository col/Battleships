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
        
        aircraftCarrier = ShipView(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        aircraftCarrier?.imageView.image = UIImage(named: "aircraftCarrier")
        gridView.addSubview(aircraftCarrier!)
        
        battleship = ShipView(frame: CGRect(x: 0, y: 30, width: 120, height: 30))
        battleship?.imageView.image = UIImage(named: "battleship")
        gridView.addSubview(battleship!)
        
        cruiser = ShipView(frame: CGRect(x: 0, y: 60, width: 90, height: 30))
        cruiser?.imageView.image = UIImage(named: "cruiser")
        gridView.addSubview(cruiser!)
        
        submarine = ShipView(frame: CGRect(x: 0, y: 90, width: 90, height: 30))
        submarine?.imageView.image = UIImage(named: "destroyer")
        gridView.addSubview(submarine!)
        
        destroyer = ShipView(frame: CGRect(x: 0, y: 120, width: 60, height: 30))
        destroyer?.imageView.image = UIImage(named: "destroyer")
        gridView.addSubview(destroyer!)
    }
    
    @IBAction
    func setShips() {
        gameChannel.setShip(ship: "aircraft_carrier", coordinates: ["a1", "a2", "a3", "a4", "a5"])
        gameChannel.setShip(ship: "battleship", coordinates: ["b1", "b2", "b3", "b4"])
        gameChannel.setShip(ship: "cruiser", coordinates: ["c1", "c2", "c3"])
        gameChannel.setShip(ship: "submarine", coordinates: ["d1", "d2", "d3"])
        gameChannel.setShip(ship: "destroyer", coordinates: ["e1", "e2"])
        
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
