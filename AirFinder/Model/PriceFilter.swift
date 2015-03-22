//
//  PriceFilter.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class PriceFilter: NSObject {
   
    var min_usd: String = ""
    var max_usd: String = ""
    var min: String = ""
    var max: String = ""
    
    init(min_usd: String, max_usd: String, min: String, max: String) {
       
        self.min_usd = min_usd
        self.max_usd = max_usd
        self.min = min
        self.max = max
    }
}
