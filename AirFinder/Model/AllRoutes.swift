//
//  AllRoutes.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class AllRoutes: NSObject {
   
    var allRoutes: Array<Route>! = Array<Route>()
    
    init(allRoutes: Array<Route>) {
     
        self.allRoutes = allRoutes
    }
}
