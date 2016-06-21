//
//  WebServiceRequest.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-26.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit

class WebServiceRequest {
    // MARK: - Properties
    

    // MARK: - Public methods

    func sendRequest(lat:Double, lon:Double, sender:AnyObject){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let url = NSURL(string: "https://lcboapi.com/stores?access_key=MDpjNDk2MDJjYy02YjdlLTExZTUtYjI1YS1mZjA5NWE4OTY2MmU6QWp1V0dqWXZnTWV4T2xEUzhRcTB3NzZoOWQ3ZG5NQXZmbWpz&lat=\(lat)&lon=\(lon)")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            // print(result)
            let resultInJson = self.convert(result!)
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            // print(resultInJson)
            
            let storesInJSon = resultInJson["result"]
            
            //Set value
            let target = sender as! ViewController
            target.stores = storesInJSon
        
            // Next, post a notification for interested listeners
            let completed = "LCBOStores_fetch_completed"
            NSNotificationCenter.defaultCenter().postNotificationName(completed, object: nil)
            
        }
        
        task.resume()
    }
    
    
    //Copied from http://stackoverflow.com/questions/33056375/how-to-fetch-and-parse-json-using-swift-2-xcode-7-ios-9
    func convert(src: NSString) -> NSDictionary {
        // convert String to NSData
        let data = src.dataUsingEncoding(NSUTF8StringEncoding)
        var error: NSError?
        
        // convert NSData to 'AnyObject'
        let anyObj: AnyObject?
        do {
            anyObj = try NSJSONSerialization.JSONObjectWithData(data!, options: [])as? [String:AnyObject]
        } catch let error1 as NSError {
            error = error1
            anyObj = nil
        }
        
        if(error != nil) {
            // If there is an error parsing JSON, print it to the console
            print("JSON Error \(error!.localizedDescription)")
            //self.showError()
            return NSDictionary()
        } else {
            
            return anyObj as! NSDictionary
        }
        
    }

    init() {
   
    }
}