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
    var outbound_segments: Array<Trip>! = Array<Trip>()
    var inbound_segments: Array<Trip>! = Array<Trip>()
    var marketing_airline_code: String = ""
    var id: String = ""
    
    init(fare: Array<Fare>, bestFare: Array<Fare>, outbound_segments: Array<Trip>, inbound_segments: Array<Trip>, marketing_airline_code: String, id: String) {
        
        self.fare = fare
        self.bestFare = bestFare
        self.outbound_segments = outbound_segments
        self.inbound_segments = inbound_segments
        self.marketing_airline_code = marketing_airline_code
        self.id = id
    }
}
