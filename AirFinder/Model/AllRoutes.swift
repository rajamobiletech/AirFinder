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
    var price_filter: PriceFilter!
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
    var filtered_routes_count: Int = 0
    var routes_count: Int = 0
    
    init(routes: Array<Route>,
        currency: Currency,
        price_filter: PriceFilter,
        alliance_filters: Array<AllianceFilter>,
        provider_filters: Array<ProviderFilter>,
        stop_type_filters: Array<ProviderFilter>,
        airline_filters: Array<ProviderFilter>, stopover_airport_filters: Array<ProviderFilter>, departure_airport_filters: Array<ProviderFilter>, arrival_airport_filters: Array<ProviderFilter>, departure_day_time_filter: Array<DurationFilter>, duration_filter: Array<DurationFilter>, stopover_duration_filter: Array<DurationFilter>, fares_query_type: String,
        query_id: String,
        filtered_routes_count: Int,
        routes_count: Int) {
     
        self.routes = routes
        self.currency = currency
        self.price_filter = price_filter
        self.alliance_filters = alliance_filters
        self.provider_filters = provider_filters
        self.stop_type_filters = stop_type_filters
        self.airline_filters = airline_filters
        self.stopover_airport_filters = stopover_airport_filters
        self.departure_airport_filters = departure_airport_filters
        self.arrival_airport_filters = arrival_airport_filters
        self.departure_day_time_filter = departure_day_time_filter
        self.duration_filter = duration_filter
        self.fares_query_type = fares_query_type
        self.query_id = query_id
        self.filtered_routes_count = filtered_routes_count
        self.routes_count = routes_count
    }
}
