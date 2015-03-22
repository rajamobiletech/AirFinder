//
//  Currency.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class Currency: NSObject {
   
    var code = ""
    var name = ""
    var symbol = ""
    var exchange_rate = ""
    
    init(code: String, name: String, symbol: String, exchange_rate: String) {
        
        self.code = code
        self.name = name
        self.symbol = symbol
        self.exchange_rate = exchange_rate
    }
}
