//
//  PriceFilter.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class PriceFilter: NSObject {
   
    var min_usd: Double
    var max_usd: Double
    var min: Double
    var max: Double
    
    init(min_usd: Double, max_usd: Double, min: Double, max: Double) {
       
        self.min_usd = min_usd
        self.max_usd = max_usd
        self.min = min
        self.max = max
    }
}
