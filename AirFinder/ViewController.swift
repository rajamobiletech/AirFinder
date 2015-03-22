//
//  ViewController.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 19/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class ViewController : UIViewController {
    
    @IBOutlet var menuView:UIView!
    @IBOutlet var searchView:UIView!
    @IBOutlet var listView:UIView!
    @IBOutlet var flightTableView:UITableView!
    
    var flightSearchViewController: FlightSearchViewController!

    
    var flights = [Flight]()
    
    var filteredFlights = [Flight]()
    
    let flightListCellIdentifier = "Cell"
    
    //self.flightTableView.registerClass(FlightCell.self, forCellReuseIdentifier: "FlightCell")
    
    override func viewDidLoad() {
        
        flightSearchViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FlightSearchViewController") as FlightSearchViewController
        flightSearchViewController.view.frame = searchView.frame
        searchView.addSubview(flightSearchViewController.view)
        
        
        let departureCode = "MAA"
        let arrivalCode = "SIN"
        let outBoundDate = "2015-05-24"
        let inBoundDate = "2015-05-29"
        
        var trip = Trip(id: "", departure_code: departureCode, departure_name: "", departure_state_code: "", departure_country_code: "", departure_country_name: "", arrival_code: arrivalCode, arrival_name: "", arrival_city: false, departure_city: false, arrival_country_code: "", arrival_country_name: "", outbound_date: outBoundDate, inbound_date: inBoundDate, trip_type: "")
        
        var tripDict = [TripOptions.Departure_code.rawValue : trip.departure_code,
            TripOptions.Arrival_code.rawValue : trip.arrival_code,
            TripOptions.Outbound_date.rawValue : trip.outbound_date,
            TripOptions.Inbound_date.rawValue : trip.inbound_date] as Dictionary<String, AnyObject>
        
        for trip in tripDict {
           
            print(trip)
        }
        
        var tripArray = [tripDict] as Array
        
        //print(,,#departureCode)
        
        var params = [
            CommonOptions.Trips.rawValue : tripArray,
            SearchOptions.Adults_count.rawValue : 1,
            SearchOptions.Children_count.rawValue : 1,
            SearchOptions.Cabin.rawValue : TicketClassOptions.Economy.rawValue,
            SearchOptions.User_country_code.rawValue : "IN",
            SearchOptions.Country_site_code.rawValue : "IN"] as Dictionary<String, AnyObject>
        
        print(params)
        
        // utilityObject.addLoading(self)
        networkManagerObject.searchFlightDetails(params, urlString: searchURL, completionHandler: {(success, data) -> () in
            
            println(data)
            
            if success {
                
                var responseDict = data as Dictionary<String, AnyObject>
                var tripID: String!
                
                if let items = responseDict[CommonOptions.Trips.rawValue] as? NSArray {
                    for item in items {
                        
                        tripID = item[CommonOptions.Id.rawValue] as String
                    }
                }
                
                let testID = String(Int(arc4random_uniform(10000)))
                let searchKey = responseDict[CommonOptions.Id.rawValue] as String
                
                params = [
                    CommonOptions.Id.rawValue : testID,
                    CommonOptions.Search_id.rawValue : searchKey,
                    CommonOptions.Trip_id.rawValue : tripID,
                    "fares_query_type": "route",
                  ] as Dictionary<String, AnyObject>
                
                println(params)
                self.mainSearch(params)
            } else {
                //DO failure operations
            }
            //utilityObject.removeLoading()
        })
        
        
        // Set menu view border
        //        menuView.layer.cornerRadius = 30.0
        //        menuView.layer.borderColor = UIColor.redColor().CGColor
        //        menuView.layer.borderWidth = 1.0
        //        menuView.clipsToBounds = true
        //        menuView.layer.shadowColor = UIColor.blackColor().CGColor
        //        menuView.layer.shadowOpacity = 0.8
        //        menuView.layer.shadowRadius = 3.0
        //        menuView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        
        // Sample Data for flightArray
        /*self.flights = [Flight(headquarter:"Chennai", name:"Air India Cargo"),
            Flight(headquarter:"Mumbai", name:"Air Deccan"),
            Flight(headquarter:"Delhi", name:"Kingfisher Airlines"),
            Flight(headquarter:"Bangalore", name:"Air Mantra"),
            Flight(headquarter:"Chennai", name:"Air Sahara"),
            Flight(headquarter:"Bangalore", name:"Merged with Jet Airways"),
            Flight(headquarter:"Delhi", name:"Air Services of India"),
            Flight(headquarter:"Chennai", name:"Airways (India) Limited"),
            Flight(headquarter:"Bangalore", name:"Ambica Airlines"),
            Flight(headquarter:"Mumbai", name:"Archana Airways"),
            Flight(headquarter:"Chennai", name:"Aryan Cargo Express"),
            Flight(headquarter:"Mumbai", name:"Bhaarat Airways"),
            Flight(headquarter:"Bangalore", name:"Crescent Air Cargo"),
            Flight(headquarter:"Chennai", name:"Damania Airways"),
            Flight(headquarter:"Mumbai", name:"Renamed Skyline NEPC"),
            Flight(headquarter:"Bangalore", name:"Darbhanga Aviations"),
            Flight(headquarter:"Delhi", name:"Deccan"),
            Flight(headquarter:"Delhi", name:"East-West Airlines"),
            Flight(headquarter:"Bangalore", name:"Elbee Airlines"),
            Flight(headquarter:"Delhi", name:"Gujarat Airways"),
            Flight(headquarter:"Chennai", name:"Himalayans Air Transport & Survey Limited"),
            Flight(headquarter:"Delhi", name:"Himalayan Aviation"),
            Flight(headquarter:"Delhi", name:"Indian"),
            Flight(headquarter:"Delhi", name:"Merged with Air India"),
            Flight(headquarter:"Mumbai", name:"Indian National Airways"),
            Flight(headquarter:"Mumbai", name:"Indian Overseas Airlines"),
            Flight(headquarter:"Bangalore", name:"Indian State Air Service (ISAS)"),
            Flight(headquarter:"Chennai", name:"Indian Transcontinental Airlines"),
            Flight(headquarter:"Mumbai", name:"Indus Airways"),
            Flight(headquarter:"Mumbai", name:"Irwaddy Flotilla & Airways"),
            Flight(headquarter:"Delhi", name:"Jamair"),
            Flight(headquarter:"Mumbai", name:"JetKonnect"),
            Flight(headquarter:"Chennai", name:"Mrged wit"),
            Flight(headquarter:"Mumbai", name:"Merged with JetKonnect"),
            Flight(headquarter:"Mumbai", name:"Jupiter Airways"),
            Flight(headquarter:"Delhi", name:"Kalinga Airlines"),
            Flight(headquarter:"Bangalore", name:"Kingfisher Airlines"),
            Flight(headquarter:"Chennai", name:"Kingfisher Red"),
            Flight(headquarter:"Mumbai", name:"MDLR Airlines"),
            Flight(headquarter:"Bangalore", name:"ModiLuft"),
            Flight(headquarter:"Delhi", name:"NEPC Airlines"),
            Flight(headquarter:"Bangalore", name:"Orient Airways"),
            Flight(headquarter:"Chennai", name:"Moved to Karachi"),
            Flight(headquarter:"Chennai", name:"Paramount Airways"),
            Flight(headquarter:"Bangalore", name:"Pushpaka Airlines"),
            Flight(headquarter:"Delhi", name:"Tata Airlines"),
            Flight(headquarter:"Mumbai", name:"Vayudoot"),
            Flight(headquarter:"Bangalore", name:"VIF Airways"),
            Flight(headquarter:"Delhi", name:"Vijay Airlines")]*/
        
        // Reload the table
      //  self.flightTableView.reloadData()
    }
    
    /*
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredFlights.count
        } else {
            return self.flights.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.flightTableView.dequeueReusableCellWithIdentifier(flightListCellIdentifier) as UITableViewCell
    
        var flight : Flight
        // Check to see whether the normal table or search results table is being displayed and set the Flight object from the appropriate array
        if tableView == self.searchDisplayController!.searchResultsTableView {
            flight = filteredFlights[indexPath.row]
        } else {
            flight = flights[indexPath.row]
        }
    
        // Configure the flight cell
       // cell.flightTitleLabel.text = flight.name
       // cell.flightSubTitleLabel.text = flight.headquarter
        cell.textLabel!.text = flight.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredFlights = self.flights.filter({( flight : Flight) -> Bool in
            var headquarterMatch = (scope == "All") || (flight.headquarter == scope)
            var stringMatch = flight.name.rangeOfString(searchText)
            return headquarterMatch && (stringMatch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        let scopes = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
        let selectedScope = scopes[self.searchDisplayController!.searchBar.selectedScopeButtonIndex] as String
        self.filterContentForSearchText(searchString, scope: selectedScope)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!,
        shouldReloadTableForSearchScope searchOption: Int) -> Bool {
            let scope = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
            self.filterContentForSearchText(self.searchDisplayController!.searchBar.text, scope: scope[searchOption])
            return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("flightDetail", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "flightDetail" {
            let flightDetailViewController = segue.destinationViewController as UIViewController
            if sender as UITableView == self.searchDisplayController!.searchResultsTableView {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                let destinationTitle = self.filteredFlights[indexPath.row].name
                flightDetailViewController.title = destinationTitle
            } else {
                let indexPath = self.flightTableView.indexPathForSelectedRow()!
                let destinationTitle = self.flights[indexPath.row].name
                flightDetailViewController.title = destinationTitle
            }
        }
    }

*/
 
    func mainSearch(params: Dictionary<String, AnyObject>) {
       
        networkManagerObject.searchFlightDetails(params, urlString: fareURL, completionHandler: {(success, data) -> () in
            
            println(data)
            
            if success {
                
                var responseDict = data as Dictionary<String, AnyObject>
                
                var obj = parserObject.parseMainSearch(responseDict) as AllRoutes
                
                //Raja - do the UI display here.
                
            } else {
                //DO failure operations
            }
            //utilityObject.removeLoading()
        })
    }
    
}


