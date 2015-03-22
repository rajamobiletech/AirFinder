//
//  Utility.swift
//  URLSession
//
//  Created by Raja Duraisamy on 21/03/15.
//  Copyright (c) 2015 self. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    var activityIndicatorView: UIActivityIndicatorView!
    var loaderView: UIView!
    var controller: UIViewController!
    
    class var sharedUtility: Utility {
        
        struct Static {
            static var instance: Utility?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Utility()
        }
        return Static.instance!
    }
    
    
    func addLoading(controller: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        self.controller = controller as UIViewController
        self.loaderView = UIView(frame: CGRectMake(appDelegate.window!.bounds.size.width/2 - 25, appDelegate.window!.bounds.size.height/2 - 25, 50, 50))
        self.loaderView.backgroundColor = UIColor.blackColor()
        self.loaderView.layer.cornerRadius = 5.0
        
        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        self.activityIndicatorView.frame = CGRectMake(0, 0, 50, 50)
        self.activityIndicatorView.startAnimating()
        
        self.loaderView.addSubview(self.activityIndicatorView)
        self.controller.view.addSubview(self.loaderView)
        self.controller.view.userInteractionEnabled = false
    }
    
    
    func removeLoading() {
        
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.removeFromSuperview()
        self.loaderView.removeFromSuperview()
        self.controller.view.userInteractionEnabled = true
        self.activityIndicatorView = nil
        self.loaderView = nil
    }
}
