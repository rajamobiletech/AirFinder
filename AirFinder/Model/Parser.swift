//
//  Parser.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 22/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class Parser: NSObject {
    
    func parseMainSearch(responseDict: NSDictionary) -> AnyObject {
        
        println(responseDict)
        
        var routesObj: Array<Route>! = Array<Route>()
        var currencyObj: Currency! = Currency.alloc()
        var outboundSegmentObj: Array<Trip>! = Array<Trip>()
        var inboundSegmentObj: Array<Trip>! = Array<Trip>()
        
        if let itemsRoute = responseDict[CommonOptions.Routes.rawValue] as? NSArray {
            
            //looping Routes
            for itemRoute in itemsRoute {
                
                var fareObjectsArray: Array<Fare>! = Array<Fare>()
                var bestFareObjectsArray: Array<Fare>! = Array<Fare>()
                
                let airlineCode = itemRoute[FareOptions.Marketing_airline_code.rawValue] as String!
                let id = itemRoute[CommonOptions.Id.rawValue] as String!
                
                //Fare parsing
                if let itemsFare = itemRoute[FareOptions.Fares.rawValue] as? NSArray {
                    
                    fareObjectsArray = self.parseFare(itemsFare)
                }
               
                //Best Fare parsing
                if let itemsFare = itemRoute[FareOptions.Best_fare.rawValue] as? NSDictionary {
                   
                    bestFareObjectsArray = self.parseFare([itemsFare])
                }
                
                //Outbound Parsing
                if let itemsBound = itemRoute[FareOptions.Outbound_segments.rawValue] as? NSArray {
                    
                    outboundSegmentObj = self.parseInOutBoundSegment(itemsBound)
                }
                
                //Inbound parsing
                if let itemsBound = itemRoute[FareOptions.Inbound_segments.rawValue] as? NSArray {
                    
                    inboundSegmentObj = self.parseInOutBoundSegment(itemsBound)
                }
                
                let routeObj = Route(fare: fareObjectsArray, bestFare: bestFareObjectsArray, outbound_segments: outboundSegmentObj, inbound_segments: inboundSegmentObj, marketing_airline_code: airlineCode, id: id) as Route
                
                routesObj.append(routeObj)
            } // End of Routes
        }  // End of Routes IF
        
        println(routesObj)
        
        //Currency parsing
        if let itemsCurrency = responseDict[FlightSearchOptions.Currency.rawValue] as? NSDictionary {
        
               currencyObj.code = itemsCurrency[CurrencyOptions.Code.rawValue] as String!
                currencyObj.name = itemsCurrency[CurrencyOptions.Name.rawValue] as String!
                currencyObj.symbol = itemsCurrency[CurrencyOptions.Symbol.rawValue] as String!
                currencyObj.exchange_rate = itemsCurrency[CurrencyOptions.Exchange_rate.rawValue] as Double!
            
            print(currencyObj)
        }
        
        let allRoutesObj = AllRoutes(routes: routesObj, currency: currencyObj)
        
        return allRoutesObj
    }
    
    
     private func parseFare(itemsFare: NSArray) -> Array<Fare> {
      
        var fareObjectsArray: Array<Fare>! = Array<Fare>()
        //looping Fares
        for itemFare  in itemsFare {
            
            let price = itemFare[FareOptions.Price.rawValue] as Double!
            let provider_code = itemFare[FareOptions.Provider_code.rawValue] as String!
            let description = itemFare[FareOptions.Description.rawValue] as String!
            
            //TODO - Need to be change alliance
            var alliance: String = ""
            /*if itemFare[FareOptions.Alliance.rawValue] != nil {
                
              alliance = itemFare[FareOptions.Alliance.rawValue] as String
            }*/
            let deeplink = itemFare[FareOptions.Deeplink.rawValue] as String!
            
            var trip_id: String!
            var route: String!
            var search_id: String!
            var placement_type: String!
            var fare_id: String!
            
            if var itemsDeep = itemFare[FareOptions.Deeplink_params.rawValue] as? NSDictionary {
                
                trip_id =  itemsDeep[CommonOptions.Trip_id.rawValue] as String!
                route =  itemsDeep[FareOptions.Route.rawValue] as String!
                search_id = itemsDeep[CommonOptions.Search_id.rawValue] as String!
                placement_type = itemsDeep[FareOptions.Placement_type.rawValue] as String!
                fare_id = itemsDeep[FareOptions.Fare_id.rawValue] as String!
            }
            
            var deepLinkObj = DeepLink(deeplinkURL: deeplink, trip_id: trip_id, route: route, search_id: search_id, placement_type: placement_type, fare_id: fare_id) as DeepLink
            
            let fare = Fare(deepLink: deepLinkObj, price: price, provider_code: provider_code, description1: description, alliance: alliance)
            
            fareObjectsArray.append(fare)
        }
        
        println(fareObjectsArray)
        return fareObjectsArray
    }
    
    
    private func parseInOutBoundSegment(itemsBound: NSArray) -> Array<Trip> {
        
        var boundObjectsArray: Array<Trip>! = Array<Trip>()
        //looping Fares
        for itemBound  in itemsBound {
            
            let departure_code = itemBound[TripOptions.Departure_code.rawValue] as String!
            let arrival_code = itemBound[TripOptions.Arrival_code.rawValue] as String!
            let departure_time = itemBound[TripOptions.Departure_time.rawValue] as String!
            let arrival_time = itemBound[TripOptions.Arrival_time.rawValue] as String!
            let designator_code = itemBound[TripOptions.Designator_code.rawValue] as String!
            let airline_code = itemBound[TripOptions.Airline_code.rawValue] as String!
            let departure_name = itemBound[TripOptions.Departure_name.rawValue] as String!
            let arrival_name = itemBound[TripOptions.Arrival_name.rawValue] as String!
            let airline_name = itemBound[TripOptions.Airline_name.rawValue] as String!
            
            let trip = Trip(id: "", departure_code: departure_code, departure_name: departure_name, departure_state_code: "", departure_country_code: "", departure_country_name: "", arrival_code: arrival_code, arrival_name: arrival_name, arrival_city: false, departure_city: false, arrival_country_code: "", arrival_country_name: "", outbound_date: "", inbound_date: "", trip_type: "", departure_time: departure_time, arrival_time: arrival_time, airline_code: arrival_code, airline_name: airline_name, designator_code: designator_code) as Trip
            
            boundObjectsArray.append(trip)
        }
        
        println(boundObjectsArray)
        return boundObjectsArray
    }
}
