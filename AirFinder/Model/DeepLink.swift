//
//  DeepLink.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class DeepLink: NSObject {
   
    var deeplinkURL = ""
    var trip_id = ""
    var route = ""
    var search_id = ""
    var placement_type = ""
    var fare_id = ""
    
    init(deeplinkURL: String, trip_id: String, route: String,search_id: String,placement_type: String,fare_id: String) {
        
        self.deeplinkURL = deeplinkURL
        self.trip_id = deeplinkURL
        self.route = route
        self.search_id = search_id
        self.placement_type = placement_type
        self.fare_id = fare_id
    }
}
