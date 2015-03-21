//
//  ViewController.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 19/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class ViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet var menuView:UIView!
    @IBOutlet var searchView:UIView!
    @IBOutlet var listView:UIView!
    @IBOutlet var flightTableView:UITableView!
    
    var flights = [Flight]()
    
    var filteredFlights = [Flight]()
    
    let flightListCellIdentifier = "Cell"
    
    //self.flightTableView.registerClass(FlightCell.self, forCellReuseIdentifier: "FlightCell")
    
    override func viewDidLoad() {
        
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
        self.flights = [Flight(headquarter:"Chennai", name:"Air India Cargo"),
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
            Flight(headquarter:"Delhi", name:"Vijay Airlines")]
        
        // Reload the table
        self.flightTableView.reloadData()
    }
    
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
}


