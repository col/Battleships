//
//  GameViewController.swift
//  Battleships
//
//  Created by Col Harris on 05/04/2017.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GridViewDelegate {
    
    @IBOutlet var gridView: UIView!
    @IBOutlet var gridViewController: GridViewController!
    
    @IBOutlet var myGridView: UIView!
    @IBOutlet var myGridViewController: GridViewController!
    
    var gameChannel: GameChannel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.tag = 1
        
        gridViewController = self.childViewControllers.first as! GridViewController
        gridViewController.delegate = self
    }
    
    func gridView(didSelectCoordinate coordinate: String) {
        gameChannel.guessCoordinate(coordinate: coordinate) { response in
            self.gridViewController.update(coordinate: coordinate, state: response?["hit"] ?? "blank")
        }
    }
    
}

