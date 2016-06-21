//
//  ViewController.swift
//  LCBO Finder
//
//  Created by Jung Geon Choi on 2016. 3. 24..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import MapKit
import Darwin

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    let locationManager = CLLocationManager()
    let webService = WebServiceRequest()
    var mapView:GMSMapView?
    var stores:AnyObject?
    var storesArray:NSArray?
    let viewDetailSegueIdentifier = "viewDetail"
    var selectedMarker:GMSMarker?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let status = Reach().connectionStatus()
        switch status {
        case .Unknown, .Offline:
            
            let alertController = UIAlertController(title: "No Internet Connection", message: "LCBO Locator requires the Internet access. Please try again with Internet connection.", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: {(action:UIAlertAction!)-> Void in
                exit(0)
                })
            
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        default:
            
        
 
        
        self.navigationItem.setRightBarButtonItem(nil, animated: false)
        
        //Notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.fetchCompleted), name: "LCBOStores_fetch_completed", object: nil)
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }else{
            let alertController = UIAlertController(title: "No Location Access", message: "LCBO Locator requires the Location access. Please try again with Location access.", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: {(action:UIAlertAction!)-> Void in
                exit(0)
            })
            
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        self.setGoogleMap()
        }
    }
    
    
    
    func fetchCompleted(){
        let storeForProcessing:NSArray = NSArray(array: stores! as! [AnyObject])
        storesArray = storeForProcessing
        for store in storeForProcessing{
            let lat = store["latitude"] as! Double
            let lon = store["longitude"] as! Double
            let title = store["name"] as! String
            let snippet = "\(store["address_line_1"] as! String)\n\(store["city"] as! String ),  \(store["postal_code"] as! String ) \n \(store["telephone"] as! String)"
            let  position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            marker.title = title
            marker.snippet = snippet
            //marker.appearAnimation = kGMSMarkerAnimationPop
            marker.userData = store;
            marker.map = mapView
        }
    }
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        selectedMarker = marker
        
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Action , target: self, action: #selector(ViewController.leftTap))
, animated: true)
        return false
    }
    
    func mapView(mapView: GMSMapView, didCloseInfoWindowOfMarker marker: GMSMarker) {
        self.navigationItem.setRightBarButtonItem(nil, animated: true)
    }
    
    func leftTap(){
        mapView(mapView!, didTapInfoWindowOfMarker: selectedMarker!)
    }
    
    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        
        
        let actionSheetController: UIAlertController = UIAlertController(title:nil, message: nil, preferredStyle: .ActionSheet)
        
        //Referenced from: http://nikolakirev.com/blog/uialertcontroller-swift-example/s
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let viewDetailAction: UIAlertAction = UIAlertAction(title: "View Detail", style: .Default) { action -> Void in
            self.showDetail()
        }
        actionSheetController.addAction(viewDetailAction)
        //Create and add a second option action
        let callStoreAction: UIAlertAction = UIAlertAction(title: "Call Store", style: .Default) { action -> Void in
            self.callStore(marker.userData!["telephone"] as! String)
        }
        actionSheetController.addAction(callStoreAction)
        
        let navigateToStoreAction: UIAlertAction = UIAlertAction(title: "Navigate to Store", style: .Default) { action -> Void in
            self.openMapForPlace()
        }
        actionSheetController.addAction(navigateToStoreAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)

    }
    
    //Copied from http://stackoverflow.com/questions/28604429/how-to-open-maps-app-programatically-with-coordinates-in-swift
    func openMapForPlace() {
        let store = selectedMarker?.userData as! NSDictionary
        let lat1 : NSString = String(store["latitude"] as! Double)
        let lng1 : NSString = String(store["longitude"] as! Double)
        
        let latitute:CLLocationDegrees =  lat1.doubleValue
        let longitute:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "LCBO @ " + (store["name"] as! String)
        mapItem.phoneNumber = store["telephone"] as? String
        mapItem.openInMapsWithLaunchOptions(options)
        
    }
    
    func callStore(phoneNumber:String){
        let array : [String] = phoneNumber.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: "()- "))
        let url = "tel://" + array[1] + array[3] + array[4]
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    func showDetail(){
        performSegueWithIdentifier(viewDetailSegueIdentifier, sender: selectedMarker);
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "helpView"{
            let destinationViewController = segue.destinationViewController as! DetailTableViewController
            destinationViewController.store = sender?.userData as? NSDictionary
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Call only once
        locationManager.stopUpdatingLocation()
        
        //Set variable
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        //Set new cemera angle
        let camera = GMSCameraPosition.cameraWithLatitude(locValue.latitude,
                                                          longitude: locValue.longitude, zoom: 13)
        mapView?.camera = camera
        webService.sendRequest(locValue.latitude, lon:locValue.longitude, sender: self)
    }

    func setGoogleMap(){
        //Initial angle @ CN Tower..
        let camera = GMSCameraPosition.cameraWithLatitude(43.6426,
                                                          longitude: -79.3871, zoom: 4)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView!.myLocationEnabled = true
        mapView!.settings.myLocationButton = true
        self.view = mapView
        
        //deligate for GSM
        mapView?.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
