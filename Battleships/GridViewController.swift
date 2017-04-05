//
//  GridViewController.swift
//  Battleships
//
//  Created by Col Harris on 05/04/2017.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class GridViewController: UICollectionViewController {
    
    let letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCell
        return cell
    }
    
    func coordinateForIndexPath(_ indexPath: IndexPath) -> String {
        return "\(letters[indexPath.section])\(indexPath.row+1)"
    }
    
    func indexPathForCoordinate(_ coordinate: String) -> IndexPath {
        let firstIndex = coordinate.index(coordinate.startIndex, offsetBy: 1)
        let section = letters.index(of: coordinate.substring(to: firstIndex))!
        let row = Int(coordinate.substring(with: firstIndex..<coordinate.endIndex))! - 1
        return IndexPath(row: row, section: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coordinate = coordinateForIndexPath(indexPath)
        let decodedIndexPath = indexPathForCoordinate(coordinate)
        print("didSelectItemAt: \(indexPath), coordinate: \(coordinate), decodedIndexPath: \(decodedIndexPath)")
        displayShipAt(indexPath: indexPath)
    }
    
    func displayShipAt(indexPath: IndexPath) {
        let view = UIView(frame: collectionView(collectionView!, cellForItemAt: indexPath).frame)
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
    }
    
}
