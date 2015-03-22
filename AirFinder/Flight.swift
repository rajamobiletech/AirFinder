//
//  flight.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 21/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import Foundation

struct Flight{
    let departure_code : String
    let arrival_code : String
    let outbound_date:String
    let inbound_date:String
    let adults_count: UInt8
    let children_count: UInt8
    let cabin:String
    let infants:UInt8
}