//
//  Fare.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class Fare: NSObject {
   
    var deepLink:DeepLink!
    var price = 0.0
    var provider_code = ""
    var description1 = ""
    var alliance = ""
    
    init(deepLink: DeepLink, price: Double, provider_code: String, description1: String, alliance: String) {
        
        self.deepLink = deepLink
        self.price = price
        self.provider_code = provider_code
        self.description1 = description1
        self.alliance = alliance
    }
    
}
