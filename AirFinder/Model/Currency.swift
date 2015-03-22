//
//  Currency.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class Currency: NSObject {
   
    var code: String!
    var name: String!
    var symbol: String!
    var exchange_rate: Double
    
    init(code: String, name: String, symbol: String, exchange_rate: Double) {
        
        self.code = code
        self.name = name
        self.symbol = symbol
        self.exchange_rate = exchange_rate
    }
}
