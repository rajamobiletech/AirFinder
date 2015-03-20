//
//  ViewController.swift
//  AirFinder
//
//  Created by Raja Duraisamy on 19/03/15.
//  Copyright (c) 2015 Raja Duraisamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var menuView:UIView!
    @IBOutlet var searchView:UIView!
    @IBOutlet var listView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        // Set menu view border
//        menuView.layer.cornerRadius = 30.0
//        menuView.layer.borderColor = UIColor.redColor().CGColor
//        menuView.layer.borderWidth = 1.0
//        menuView.clipsToBounds = true
//        menuView.layer.shadowColor = UIColor.blackColor().CGColor
//        menuView.layer.shadowOpacity = 0.8
//        menuView.layer.shadowRadius = 3.0
//        menuView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
//
//        // Set menu view border
//        searchView.layer.cornerRadius = 30.0
//        searchView.layer.borderColor = UIColor.redColor().CGColor
//        searchView.layer.borderWidth = 1.0
//        searchView.clipsToBounds = true
//        searchView.layer.shadowColor = UIColor.blackColor().CGColor
//        searchView.layer.shadowOpacity = 0.8
//        searchView.layer.shadowRadius = 3.0
//        searchView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
//        
//        // Set menu view border
//        listView.layer.cornerRadius = 30.0
//        listView.layer.borderColor = UIColor.redColor().CGColor
//        listView.layer.borderWidth = 1.0
//        listView.clipsToBounds = true
//        listView.layer.shadowColor = UIColor.blackColor().CGColor
//        listView.layer.shadowOpacity = 0.8
//        listView.layer.shadowRadius = 3.0
//        listView.layer.shadowOffset = CGSizeMake(2.0, 2.0);

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

