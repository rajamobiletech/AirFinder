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
    
    var candies = [Flight]()
    
    var filteredFlights = [Flight]()
    
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
        self.candies = [Flight(category:"Chennai", name:"Air India Cargo"),
            Flight(category:"Mumbai", name:"Air Deccan"),
            Flight(category:"Delhi", name:"Kingfisher Airlines"),
            Flight(category:"Bangalore", name:"Air Mantra"),
            Flight(category:"Chennai", name:"Air Sahara"),
            Flight(category:"Bangalore", name:"Merged with Jet Airways"),
            Flight(category:"Delhi", name:"Air Services of India"),
            Flight(category:"Chennai", name:"Airways (India) Limited"),
            Flight(category:"Bangalore", name:"Ambica Airlines"),
            Flight(category:"Mumbai", name:"Archana Airways"),
            Flight(category:"Chennai", name:"Aryan Cargo Express"),
            Flight(category:"Mumbai", name:"Bhaarat Airways"),
            Flight(category:"Bangalore", name:"Crescent Air Cargo"),
            Flight(category:"Chennai", name:"Damania Airways"),
            Flight(category:"Mumbai", name:"Renamed Skyline NEPC"),
            Flight(category:"Bangalore", name:"Darbhanga Aviations"),
            Flight(category:"Delhi", name:"Deccan"),
            Flight(category:"Delhi", name:"East-West Airlines"),
            Flight(category:"Bangalore", name:"Elbee Airlines"),
            Flight(category:"Delhi", name:"Gujarat Airways"),
            Flight(category:"Chennai", name:"Himalayans Air Transport & Survey Limited"),
            Flight(category:"Delhi", name:"Himalayan Aviation"),
            Flight(category:"Delhi", name:"Indian"),
            Flight(category:"Delhi", name:"Merged with Air India"),
            Flight(category:"Mumbai", name:"Indian National Airways"),
            Flight(category:"Mumbai", name:"Indian Overseas Airlines"),
            Flight(category:"Bangalore", name:"Indian State Air Service (ISAS)"),
            Flight(category:"Chennai", name:"Indian Transcontinental Airlines"),
            Flight(category:"Mumbai", name:"Indus Airways"),
            Flight(category:"Mumbai", name:"Irwaddy Flotilla & Airways"),
            Flight(category:"Delhi", name:"Jamair"),
            Flight(category:"Mumbai", name:"JetKonnect"),
            Flight(category:"Chennai", name:"Mrged wit"),
            Flight(category:"Mumbai", name:"Merged with JetKonnect"),
            Flight(category:"Mumbai", name:"Jupiter Airways"),
            Flight(category:"Delhi", name:"Kalinga Airlines"),
            Flight(category:"Bangalore", name:"Kingfisher Airlines"),
            Flight(category:"Chennai", name:"Kingfisher Red"),
            Flight(category:"Mumbai", name:"MDLR Airlines"),
            Flight(category:"Bangalore", name:"ModiLuft"),
            Flight(category:"Delhi", name:"NEPC Airlines"),
            Flight(category:"Bangalore", name:"Orient Airways"),
            Flight(category:"Chennai", name:"Moved to Karachi"),
            Flight(category:"Chennai", name:"Paramount Airways"),
            Flight(category:"Bangalore", name:"Pushpaka Airlines"),
            Flight(category:"Delhi", name:"Tata Airlines"),
            Flight(category:"Mumbai", name:"Vayudoot"),
            Flight(category:"Bangalore", name:"VIF Airways"),
            Flight(category:"Delhi", name:"Vijay Airlines")]
        
        // Reload the table
        self.flightTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredFlights.count
        } else {
            return self.candies.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        let cell = self.flightTableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        var flight : Flight
        // Check to see whether the normal table or search results table is being displayed and set the Flight object from the appropriate array
        if tableView == self.searchDisplayController!.searchResultsTableView {
            flight = filteredFlights[indexPath.row]
        } else {
            flight = candies[indexPath.row]
        }
        
        // Configure the cell
        cell.textLabel!.text = flight.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredFlights = self.candies.filter({( flight : Flight) -> Bool in
            var categoryMatch = (scope == "All") || (flight.category == scope)
            var stringMatch = flight.name.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
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
                let destinationTitle = self.candies[indexPath.row].name
                flightDetailViewController.title = destinationTitle
            }
        }
    }
}


