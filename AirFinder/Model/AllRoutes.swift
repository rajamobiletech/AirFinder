//
//  AllRoutes.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class AllRoutes: NSObject {
   
    var currency:Currency!
    var routes: Array<Route>! = Array<Route>()
    var price_filter: Array<PriceFilter>! = Array<PriceFilter>()
    var alliance_filters: Array<AllianceFilter>! = Array<AllianceFilter>()
    
    var provider_filters: Array<ProviderFilter>! = Array<ProviderFilter>()
    var stop_type_filters: Array<ProviderFilter>! = Array<ProviderFilter>()
    var airline_filters: Array<ProviderFilter>! = Array<ProviderFilter>()
    var stopover_airport_filters: Array<ProviderFilter>! = Array<ProviderFilter>()
    var departure_airport_filters: Array<ProviderFilter>! = Array<ProviderFilter>()
    var arrival_airport_filters: Array<ProviderFilter>! = Array<ProviderFilter>()
    
    var departure_day_time_filter: Array<DurationFilter>! = Array<DurationFilter>()
    var duration_filter: Array<DurationFilter>! = Array<DurationFilter>()
    var stopover_duration_filter: Array<DurationFilter>! = Array<DurationFilter>()
    
    var fares_query_type: String = ""
    var query_id: String = ""
    var filtered_routes_count: String = ""
    var routes_count: String = ""
    
    init(routes: Array<Route>, currency: Currency) {
     
        self.routes = routes
        self.currency = currency
    }
}
