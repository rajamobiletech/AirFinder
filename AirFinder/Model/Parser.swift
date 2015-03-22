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
        
        if let itemsRoute = responseDict[CommonOptions.Routes.rawValue] as? NSArray {
            
            //looping Routes
            for itemRoute in itemsRoute {
                
                var fareObjectsArray: Array<Fare>! = Array<Fare>()
                var bestFareObjectsArray: Array<Fare>! = Array<Fare>()
                
                let airlineCode = itemRoute[FareOptions.Marketing_airline_code.rawValue] as String!
                let id = itemRoute[CommonOptions.Id.rawValue] as String!
                
                if let itemsFare = itemRoute[FareOptions.Fares.rawValue] as? NSArray {
                    
                    fareObjectsArray = self.parseFare(itemsFare)
                }
               
                if let itemsFare = itemRoute[FareOptions.Best_fare.rawValue] as? NSDictionary {
                   
                    bestFareObjectsArray = self.parseFare([itemsFare])
                }
                
                let routeObj = Route(fare: fareObjectsArray, bestFare: bestFareObjectsArray, outbound_segments: Array(), inbound_segments: Array(), marketing_airline_code: airlineCode, id: id) as Route
                
                routesObj.append(routeObj)
            } // End of Routes
        }  // End of Routes IF
        
        println(routesObj)
        
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
    
     func parseFare(itemsFare: NSArray) -> Array<Fare> {
      
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
}
