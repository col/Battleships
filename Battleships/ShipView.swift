//
//  ShipView.swift
//  Battleships
//
//  Created by Colin Harris on 6/4/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class ShipView: UIView {
    
    var touchDown: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isMultipleTouchEnabled = true
        self.backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchDown = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchDown {
            let newPos = touches.first?.location(in: self.superview)
            self.frame = CGRect(x: newPos!.x, y: newPos!.y, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchDown = false
        let gridPos = touches.first!.location(in: gridView())
        print("gridPos = \(gridPos)")
        
        let xAdjust = (gridPos.x - 3).truncatingRemainder(dividingBy: 30)
        let yAdjust = (gridPos.y - 3).truncatingRemainder(dividingBy: 30)
        print("xAdjust = \(xAdjust)")
        print("yAdjust = \(xAdjust)")
        
        self.frame = CGRect(
            x: self.frame.origin.x - xAdjust,
            y: self.frame.origin.y - yAdjust,
            width: self.frame.size.width,
            height: self.frame.size.height
        )
        print("frame = \(self.frame)")
    }
    
    func gridView() -> UIView {
        return self.superview!.viewWithTag(1)!
    }
    
}
