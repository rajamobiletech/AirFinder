//
//  FlightSearchViewController.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 21/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate{
    func hideSearchView(controller:FlightSearchViewController,text:String)
}


class FlightSearchViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    var delegate:SearchViewControllerDelegate! = nil
    var currentData: Array<AnyObject>! = Array<AnyObject>()
    
    var currentTextField:UITextField!
    var currentButton:UIButton!
    
    @IBOutlet var departureTextField: UITextField!
    @IBOutlet var ArrivalTextField: UITextField!
    
    @IBOutlet var autoTableView: UITableView!
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var baseDateView: UIView!
    
    @IBAction func onClassButtonTapped(sender:AnyObject) {
        for var i = 501; i < 504; i++ {
            var TempButton = self.view.viewWithTag(i) as? UIButton
            TempButton?.selected = false
            TempButton?.titleLabel?.font = UIFont.systemFontOfSize(12)
        }
        var classButton = self.view.viewWithTag(sender.tag) as? UIButton
        classButton?.selected=true
        classButton?.titleLabel?.font = UIFont.boldSystemFontOfSize(12);
    }
    
    @IBAction func onDateSelectionButtonTapped(sender: AnyObject) {
        currentButton = self.view.viewWithTag(sender.tag) as? UIButton
        baseDateView.frame = CGRectMake(baseDateView.frame.origin.x, currentButton.frame.origin.y + currentButton.frame.height, baseDateView.frame.width, baseDateView.frame.height)
        baseDateView.hidden = false
    }
    
    @IBAction func onSelectButtonTapped(sender: AnyObject) {
        let selectedDate:NSDate = datePicker.date as NSDate
        baseDateView.hidden = true
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss";
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        currentButton.setTitle(dateFormatter.stringFromDate(selectedDate), forState: UIControlState.Normal);
    }
    
    @IBAction func onCheckboxTapped(sender: AnyObject) {
        var tempButton = self.view.viewWithTag(sender.tag) as? UIButton
        if (tempButton?.selected == true) {
            tempButton?.setTitle("0", forState: UIControlState.Normal)
            tempButton?.selected = false
        } else {
            tempButton?.setTitle("1", forState: UIControlState.Normal)
            tempButton?.selected = true
        }
    }
    
    @IBAction func onPersonCountTapped(sender: AnyObject) {
        var tempButton = self.view.viewWithTag(sender.tag) as? UIButton
        if sender.tag > 400 {
            var tempLabel = self.view.viewWithTag(sender.tag - 200) as? UILabel
            var exsistValue:Int? = tempLabel?.text?.toInt()
            tempLabel?.text = (exsistValue! - 1) < 0 ? "0" : String(exsistValue! - 1)
        } else {
            var tempLabel = self.view.viewWithTag(sender.tag - 100) as? UILabel
            let exsistValue:Int? = tempLabel?.text?.toInt()
            tempLabel?.text = (exsistValue! + 1) > 9 ? "9" : String(exsistValue! + 1)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var imageView = UIImageView(image: UIImage(named: "Departure_icon"))
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        departureTextField.rightView = imageView
        departureTextField.rightViewMode = UITextFieldViewMode.Always
        
        imageView = UIImageView(image: UIImage(named: "Arrival_icon"))
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        ArrivalTextField.rightView = imageView
        ArrivalTextField.rightViewMode = UITextFieldViewMode.Always
        
        
        autoTableView.hidden = true;
        departureTextField.delegate = self;
        ArrivalTextField.delegate = self;
        // Do any additional setup after loading the view.
        // Set menu view border
            autoTableView.layer.cornerRadius = 10.0
            autoTableView.layer.borderColor = UIColor.lightGrayColor().CGColor
            autoTableView.layer.borderWidth = 1.0
            autoTableView.clipsToBounds = true
            autoTableView.layer.shadowColor = UIColor.blackColor().CGColor
            autoTableView.layer.shadowOpacity = 0.8
            autoTableView.layer.shadowRadius = 3.0
            autoTableView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closeSearchView(sender: AnyObject) {
        delegate!.hideSearchView(self, text: "Hide")
    }
    
    @IBAction func onSearchFlightTapped(AnyObject) {
        delegate!.hideSearchView(self, text: "Hide")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK:
    // MARK: UITableViewDatasource methods
    func tableView(tableView: UITableView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       // let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "AutoSuggestionCell")
        
        let cell = self.autoTableView.dequeueReusableCellWithIdentifier("AutoSuggestionCell") as AutoSuggestionCell
        
        let infoDict = currentData[indexPath.row] as NSDictionary
        cell.AirportName?.text = infoDict.objectForKey("name") as String!
        cell.AirportCode?.text = infoDict.objectForKey("code") as String!
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoDict = currentData[indexPath.row] as NSDictionary
        var airportName = infoDict.objectForKey("name") as String!
        var airportCode = infoDict.objectForKey("code") as String!
        currentTextField.text = airportCode + " - " + airportName
        autoTableView.hidden = true
        currentTextField.resignFirstResponder()

    }
    // MARK: UITextFieldDelegate methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        currentTextField = textField
        currentData = []
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        autoTableView.frame = CGRectMake(currentTextField.frame.origin.x, currentTextField.frame.origin.y+currentTextField.frame.height, autoTableView.frame.width, autoTableView.frame.height)
        currentTextField.becomeFirstResponder()
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        currentTextField.resignFirstResponder()
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var inputString = "\(textField.text)\(string)"
        var inputString1 = "\(textField.text)"
        if inputString == "" {
            currentData = []
            autoTableView.hidden = true
        } else {
            currentData = self.sortAirportUsingName(inputString,from: airportDetails)
            autoTableView.hidden = false
        }
        autoTableView.reloadData()
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        currentData = []
        autoTableView.reloadData()
        autoTableView.hidden = true
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        autoTableView.hidden = true
        return true
    }
    
    func sortAirportUsingName(name: String,from: NSArray) -> Array<AnyObject> {
        var airportArray: Array<AnyObject> = Array<AnyObject>()
        for airportDetail in from {
            let airportName = airportDetail.objectForKey("name") as String
            let airportCode = airportDetail.objectForKey("code") as String
            if airportName.lowercaseString.rangeOfString(name) != nil || airportCode.lowercaseString.rangeOfString(name) != nil {
                airportArray.append(airportDetail)
            }
        }
        return airportArray
    }
}
