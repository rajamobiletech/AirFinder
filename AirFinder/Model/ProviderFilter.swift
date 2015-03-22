//
//  ProviderFilter.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class ProviderFilter: NSObject {
  
    var code :String = ""
    var name:String = ""
    var price_min:String = ""
    
    init(code: String, name: String, price_min: String) {
       
        self.code = code
        self.name = name
        self.price_min = price_min
    }
}
