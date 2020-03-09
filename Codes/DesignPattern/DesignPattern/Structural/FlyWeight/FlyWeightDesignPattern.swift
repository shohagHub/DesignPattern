//
//  FlyWeightDesignPattern.swift
//  DesignPattern
//
//  Created by Saleh Enam Shohag on 9/2/20.
//  Copyright © 2020 Saleh Enam Shohag. All rights reserved.
//

import UIKit

class FlyWeightDesignPattern: NSObject {

}

//lets separate mesh and texture in different class
class SharedSpaceShipData{
    private let mesh: [Float]
    private let texture: UIImage?
    
    init(mesh: [Float], imageNamed name: String){
        self.mesh = mesh
        self.texture = UIImage(named: name)
    }
}

class SpaceShip{
    private var positon: (Float, Float, Float)
    private var intrinsicState: SharedSpaceShipData
    
    init(sharedData: SharedSpaceShipData,
         position: (Float, Float, Float) = (0, 0, 0)) {
        self.positon = position
        self.intrinsicState = sharedData
    }
}
func testNaive(){
    let fleetSize = 1000
    var ships = [SpaceShip]()
    
    let vertices = [Float](repeating: 0, count: 1000)
    let sharedSpace = SharedSpaceShipData(mesh: vertices, imageNamed: "SpaceShip")
    for _ in 0..<fleetSize {
        let ship = SpaceShip(sharedData: sharedSpace,
                             position: (Float.random(in: 1...100),
                                                                                 Float.random(in: 0...100),
                                                                                 Float.random(in: 0...100)))
        ships.append(ship)
    }
}
/*
func testNaive(){
    let fleetSize = 1000
    var ships = [SpaceShip]()
    var vertices = [Float](repeating: 0, count: 1000)
    for _ in 0..<fleetSize {
        let ship = SpaceShip(mesh: vertices, imageNamed: "SpaceShip", position: (Float.random(in: 1...100),
                                                                                 Float.random(in: 0...100),
                                                                                 Float.random(in: 0...100)))
        ships.append(ship)
    }
}*/


