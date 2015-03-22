//
//  AllianceFilter.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class AllianceFilter: NSObject {
  
    var code: String = ""
    var count: String = ""
    
    init(code: String, count: String) {
        
        self.code = code
        self.count = count
    }
}
