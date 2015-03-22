//
//  Route.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class Route: NSObject {
    
    var fare: Array<Fare>! = Array<Fare>()
    var bestFare: Array<Fare>! = Array<Fare>()
    
    init(fare: Array<Fare>, bestFare: Array<Fare>) {
        
        self.fare = fare
        self.bestFare = bestFare
    }
}
