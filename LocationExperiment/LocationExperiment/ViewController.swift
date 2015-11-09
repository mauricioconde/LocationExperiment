//
//  ViewController.swift
//  LocationExperiment
//
//  Created by Mauricio Conde on 03/02/15.
//  Copyright (c) 2015 gbmobile. All rights reserved.
//

import UIKit

import CoreLocation


class ViewController: UIViewController , CLLocationManagerDelegate{
    
    
    
    var locationManager:CLLocationManager!
    
    var latitudeLbl:UILabel!
    var longitudeLbl:UILabel!
    
    let BUTTON_TITLE = "Update position", LATITUDE_LABEL = "Latitude:", LONGITUDE_LABEL = "Longitude:"
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        myButton.backgroundColor = UIColor.brownColor()
        myButton.layer.masksToBounds = true
        myButton.setTitle(BUTTON_TITLE, forState: .Normal)
        myButton.layer.cornerRadius = 10.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/2)
        
        myButton.addTarget(self, action: "displayLocation:", forControlEvents: .TouchUpInside)
        
        
        
        // Generate one label to display latitude
        latitudeLbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30))
        latitudeLbl.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/2+100)
        
        // Generate one label to display longitude
        longitudeLbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30))
        longitudeLbl.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/2+130)
        
        self.view.addSubview(latitudeLbl)
        self.view.addSubview(longitudeLbl)
        
        
        
        
        
        //Get the location
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        
        
        // Get the status of security authentication.
        let status = CLLocationManager.authorizationStatus()
        
        
        
        // show the authentication state
        if(status == CLAuthorizationStatus.NotDetermined) {
            print("didChangeAuthorizationStatus:\(status)");
            
            // If you do not yet have obtained approval, displays the authentication dialog.
            self.locationManager.requestAlwaysAuthorization()
            
        }
        
        // Setting location accuracy.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Setting location frequency
        locationManager.distanceFilter = 100
        
        self.view.addSubview(myButton)
        
    }
    
    
    //Delegate Methods
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("didChangeAuthorizationStatus");
        
        
        
        // display authentication status in the log
        var statusStr = "";
        
        switch (status) {
            
        case .NotDetermined:
            statusStr = "NotDetermined"
            
        case .Restricted:
            statusStr = "Restricted"
            
        case .Denied:
            statusStr = "Denied"
            
        case .AuthorizedAlways:
            statusStr = "Authorized"
            
        case .AuthorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
            
        }
        
        print("CLAuthorizationStatus: \(statusStr)")
        
    }
    
    // Deleget method called when a successful update position occours
    func locationManager(manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
        
        // Display latitude and longitude
        latitudeLbl.text = "\(LATITUDE_LABEL) \(manager.location!.coordinate.latitude)"
        latitudeLbl.textAlignment = NSTextAlignment.Center
        
        longitudeLbl.text = "\(LONGITUDE_LABEL) \(manager.location!.coordinate.longitude)"
        longitudeLbl.textAlignment = NSTextAlignment.Center
        
        print("Coordinates = \(manager.location!.coordinate.longitude) + \(manager.location!.coordinate.latitude)")
        
    }
    
    
    
    // Delegate that will be called when it fails to position information acquisition.
    func locationManager(manager: CLLocationManager,didFailWithError error: NSError){
        print("error", terminator: "")
        
    }
    
    // Button event
    func displayLocation(sender: UIButton){
        locationManager.startUpdatingLocation()
    }
    
    
}
