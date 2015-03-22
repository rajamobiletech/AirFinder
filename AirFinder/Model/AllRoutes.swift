//
//  AllRoutes.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class AllRoutes: NSObject {
   
    var currency: Array<Currency>! = Array<Currency>()
    var routes: Array<Route>! = Array<Route>()
    
    init(routes: Array<Route>) {
     
        self.routes = routes
    }
}
