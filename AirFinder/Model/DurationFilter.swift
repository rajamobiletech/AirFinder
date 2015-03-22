//
//  DurationFilter.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class DurationFilter: NSObject {
   
    var max: String = ""
    var min: String = ""
    
    init(min: String, max: String) {
        
        self.min = min
        self.max = max
    }
}
