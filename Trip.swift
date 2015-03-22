//
//  Trip.swift
//  URLSession
//
//  Created by Raja Duraisamy on 21/03/15.
//  Copyright (c) 2015 self. All rights reserved.
//

import UIKit

class Trip: NSObject {
    
    var id = ""
    var departure_code = ""
    var departure_name = ""
    var departure_state_code = ""
    var departure_country_code = ""
    var departure_country_name = ""
    var arrival_code = ""
    var arrival_name = ""
    var arrival_city = false
    var departure_city = false
    var arrival_country_code = ""
    var arrival_country_name = ""
    var outbound_date = ""
    var inbound_date = ""
    var trip_type = ""
    var departure_time = ""
    var arrival_time = ""
    var airline_code = ""
    var airline_name = ""
    var designator_code = ""
    
    init(id: String, departure_code: String, departure_name: String, departure_state_code: String, departure_country_code: String, departure_country_name: String, arrival_code: String, arrival_name: String,arrival_city: Bool, departure_city: Bool, arrival_country_code: String, arrival_country_name: String, outbound_date: String, inbound_date: String, trip_type: String, departure_time: String, arrival_time: String, airline_code: String,airline_name: String, designator_code: String) {
     
        self.id = id
        self.departure_code = departure_code
        self.departure_name = departure_name
        self.departure_state_code = departure_state_code
        self.departure_country_code = departure_country_code
        self.departure_country_name = departure_country_name
        self.arrival_code = arrival_code
        self.arrival_name = arrival_name
        self.arrival_city = arrival_city
        self.departure_city = departure_city
        self.arrival_country_code = arrival_country_code
        self.arrival_country_name = arrival_country_name
        self.outbound_date = outbound_date
        self.inbound_date = inbound_date
        self.trip_type = trip_type
        self.departure_time = departure_time
        self.arrival_time = arrival_time
        self.airline_code = airline_code
        self.airline_code = airline_name
        self.designator_code = designator_code
    }
    
}
