//
//  NetworkManager.swift
//  URLSession
//
//  Created by Raja Duraisamy on 21/03/15.
//  Copyright (c) 2015 self. All rights reserved.
//

let kTimeOut = NSTimeInterval.abs(60.0)

import UIKit

class NetworkManager: NSObject {
    
    class var sharedNetwork: NetworkManager {
        
        struct Static {
            static var instance: NetworkManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = NetworkManager()
        }
        return Static.instance!
    }
    
    
    func searchFlightDetails(params : Dictionary<String, AnyObject>, urlString : String,completionHandler : (success: Bool, data : AnyObject) -> ())
    {
        self.sendRequest(params, urlString: urlString, completionHandler: {(data, urlResponse, error, httpCode) -> () in
            
            var err = error as Bool
            
            if httpCode == 200 && err == false {
                
                //Success part //TODO - parsing
                var error:NSError?
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &error) as? NSDictionary
                
                completionHandler(success: true, data: json!)
            } else {
                completionHandler(success: false, data: "")
            }
        })
    }
    
    
    func sendRequest(params : Dictionary<String, AnyObject>, urlString : String, completionHandler : (data: NSData, urlResponse: NSURLResponse,error: Bool,httpCode: Int) -> ()) {
        
        var err: NSError?
        let url = NSURL(string: urlString)
        var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: kTimeOut)
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration)
        
        request.HTTPMethod = kHttpTypePost
        request.addValue(kAppJson, forHTTPHeaderField: kContentType)
        request.addValue(kAppJson, forHTTPHeaderField: kAccept)
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.allZeros, error: &err)
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse!
            let errorStatus = err == nil ? false : true
            
            completionHandler(data: data, urlResponse: response, error: errorStatus, httpCode: httpResponse.statusCode)
        })
        task.resume()
    }
}
