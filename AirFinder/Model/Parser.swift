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
        var currencyObj = Currency.alloc()
        var priceFilter = PriceFilter.alloc()
        var providerFilterObjArr: Array<ProviderFilter>! = Array<ProviderFilter>()
        var allianceFilterObjArr: Array<AllianceFilter>! = Array<AllianceFilter>()
        var stopTypeFiltersObjArr: Array<ProviderFilter>! = Array<ProviderFilter>()
        var airlineFiltersObjArr: Array<ProviderFilter>! = Array<ProviderFilter>()
        var stopoverAirportFilterObjArr: Array<ProviderFilter>! = Array<ProviderFilter>()
        var departureAirportFilterObjArr: Array<ProviderFilter>! = Array<ProviderFilter>()
        var arrivalAirportFilterObjArr: Array<ProviderFilter>! = Array<ProviderFilter>()
        
        var departureDayTimeFilterObjArr: Array<DurationFilter>! = Array<DurationFilter>()
        var durationFilterObjArr: Array<DurationFilter>! = Array<DurationFilter>()
        var stopoverDurationFilterObjArr: Array<DurationFilter>! = Array<DurationFilter>()
        
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
        }//END - //Currency parsing
        
        //price_filter parsing
        if let itemsPriceFilter = responseDict[FlightSearchOptions.Price_filter.rawValue] as? NSDictionary {
            
            priceFilter.min_usd = itemsPriceFilter[FlightFilterOptions.Min_usd.rawValue] as Double
            priceFilter.max_usd = itemsPriceFilter[FlightFilterOptions.Max_usd.rawValue] as Double
            priceFilter.min = itemsPriceFilter[FlightFilterOptions.Min.rawValue] as Double
            priceFilter.max = itemsPriceFilter[FlightFilterOptions.Max.rawValue] as Double
            
            print(priceFilter)
        }//END -  //price_filter parsing
        
        //provider_filters parsing
        if let itemsProviders = responseDict[FlightSearchOptions.Provider_filters.rawValue] as? NSArray {
            
                providerFilterObjArr = self.parseProviderFilter(itemsProviders)
        }//End - provider_filters parsing
        
        //alliance_filters parsing
        if let itemsAllianProviders = responseDict[FlightSearchOptions.Alliance_filters.rawValue] as? NSArray {
            
            for itemProvider in itemsAllianProviders {
                
                var code: String = ""
                var count: String = ""
                
                println(itemProvider[FlightFilterOptions.Code.rawValue])
                println(itemProvider[FlightFilterOptions.Count.rawValue])
                
                if let code1 = itemProvider[FlightFilterOptions.Code.rawValue] as? String {
                    code = code1
                }
                if let count1 = itemProvider[FlightFilterOptions.Count.rawValue] as? String {
                    count = count1
                }
                
                var allianFilterObj = AllianceFilter(code: code, count: count)
                
                allianceFilterObjArr.append(allianFilterObj)
            }
        }//End - alliance_filters parsing
        
        //stop_type_filters parsing
        if let itemsstopProviders = responseDict[FlightSearchOptions.Stop_type_filters.rawValue] as? NSArray {
        
                stopTypeFiltersObjArr = self.parseProviderFilter(itemsstopProviders)
        }//End - stop_type_filters parsing
        
        //airline_filters parsing
        if let itemsAirlineProviders = responseDict[FlightSearchOptions.Airline_filters.rawValue] as? NSArray {
            
            airlineFiltersObjArr = self.parseProviderFilter(itemsAirlineProviders)
        }//End - airline_filters parsing
        
        
        //Stopover_airport_filters parsing
        if let itemsstopOverProviders = responseDict[FlightSearchOptions.Stopover_airport_filters.rawValue] as? NSArray {
            
            stopoverAirportFilterObjArr = self.parseProviderFilter(itemsstopOverProviders)
        }//End - Stopover_airport_filters parsing
        
        
        //Departure_airport_filters parsing
        if let itemssDepartAirport = responseDict[FlightSearchOptions.Departure_airport_filters.rawValue] as? NSArray {
            
            departureAirportFilterObjArr = self.parseProviderFilter(itemssDepartAirport)
        }//End - Departure_airport_filters parsing
        
        //Arrival_airport_filters parsing
        if let itemssArrivAirport = responseDict[FlightSearchOptions.Arrival_airport_filters.rawValue] as? NSArray {
            
            arrivalAirportFilterObjArr = self.parseProviderFilter(itemssArrivAirport)
        }//End - Arrival_airport_filters parsing
        
        //Departure_day_time_filter parsing
        if let itemssArrivAirport = responseDict[FlightSearchOptions.Departure_day_time_filter.rawValue] as? NSArray {
            
            departureDayTimeFilterObjArr = self.parseDurationFilter(itemssArrivAirport)
        }//End - Departure_day_time_filter parsing
        
        //Duration_filter parsing
        if let itemssArrivAirport = responseDict[FlightSearchOptions.Duration_filter.rawValue] as? NSArray {
            
            durationFilterObjArr = self.parseDurationFilter(itemssArrivAirport)
        }//End - Duration_filter parsing
        
        //Stopover_duration_filter parsing
        if let itemssArrivAirport = responseDict[FlightSearchOptions.Stopover_duration_filter.rawValue] as? NSArray {
            
            stopoverDurationFilterObjArr = self.parseDurationFilter(itemssArrivAirport)
        }//End - Stopover_duration_filter parsing
        
        let faresQueryType = responseDict[FlightSearchOptions.Fares_query_type.rawValue] as String
        let filteredRoutesCount = responseDict[FlightSearchOptions.Filtered_routes_count.rawValue] as Int
        let routesCount = responseDict[FlightSearchOptions.Routes_count.rawValue] as Int
        
        let allRoutesObj = AllRoutes(routes: routesObj, currency: currencyObj, price_filter: priceFilter, alliance_filters: allianceFilterObjArr, provider_filters: providerFilterObjArr, stop_type_filters: stopTypeFiltersObjArr, airline_filters: airlineFiltersObjArr, stopover_airport_filters: stopoverAirportFilterObjArr, departure_airport_filters: departureAirportFilterObjArr, arrival_airport_filters: arrivalAirportFilterObjArr, departure_day_time_filter: departureDayTimeFilterObjArr, duration_filter: durationFilterObjArr, stopover_duration_filter: stopoverDurationFilterObjArr, fares_query_type: faresQueryType, query_id: "", filtered_routes_count: filteredRoutesCount, routes_count: routesCount)
        
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
    
    
    private func parseProviderFilter(itemsProviders: NSArray) -> Array<ProviderFilter> {
    
     var providerObjectsArray: Array<ProviderFilter>! = Array<ProviderFilter>()
    
        for itemProvider in itemsProviders {
            
            var code :String = ""
            var name:String = ""
            var price_min:String = ""
            
            println(itemProvider[FlightFilterOptions.Code.rawValue])
            println(itemProvider[FlightFilterOptions.Name.rawValue])
            println(itemProvider[FlightFilterOptions.Price_min.rawValue])
            
            if let code1 = itemProvider[FlightFilterOptions.Code.rawValue] as? String {
                code = code1
            }
            if let name1 = itemProvider[FlightFilterOptions.Name.rawValue] as? String {
                name = name1
            }
            if let priceMin1 = itemProvider[FlightFilterOptions.Price_min.rawValue] as? String {
                price_min = priceMin1
            }
            var providersFilterObj = ProviderFilter(code: code, name: name, price_min: price_min)
            providerObjectsArray.append(providersFilterObj)
        }
        
        return providerObjectsArray
    }
    
    
    private func parseDurationFilter(itemsProviders: NSArray) -> Array<DurationFilter> {
        
        var providerObjectsArray: Array<DurationFilter>! = Array<DurationFilter>()
        
        for itemProvider in itemsProviders {
            
            var min :String = ""
            var max:String = ""
            
            println(itemProvider[FlightFilterOptions.Min.rawValue])
            println(itemProvider[FlightFilterOptions.Max.rawValue])
            
            if let min1 = itemProvider[FlightFilterOptions.Min.rawValue] as? String {
                min = min1
            }
            if let max1 = itemProvider[FlightFilterOptions.Max.rawValue] as? String {
                max = max1
            }
            var durationFilterObj = DurationFilter(min: min, max: max)
            providerObjectsArray.append(durationFilterObj)
        }
        
        return providerObjectsArray
    }
}
