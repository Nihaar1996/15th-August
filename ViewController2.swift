//
//  ViewController2.swift
//  15th August
//
//  Created by Apple on 15/08/15.
//  Copyright (c) 2015 nihaar. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController2: UIViewController, CLLocationManagerDelegate



{//each outlet is connected to a text box on the screen
    
    @IBOutlet var locality: UILabel?
    @IBOutlet var postalCode: UILabel?
    @IBOutlet var AdministrativeArea: UILabel?
    @IBOutlet var country: UILabel?
    @IBOutlet var latitude: UILabel?
    @IBOutlet var longitude: UILabel?
    
    var currentLocation = CLLocation()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        self.locationManager.requestWhenInUseAuthorization()
        //self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        currentLocation = locationManager.location!

        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    //
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil)
            {
                print("Error: " + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0
            {
                let pm = placemarks![0]
                
                self.displayLocationInfo(pm)
            }
            else
            {
                print("Error with the data.")
            }
        })
        
//        CLLocation.distanceFromLocation(CLLocation);.
        
        
    }

    
    func displayLocationInfo(placemark: CLPlacemark)
    {
        
        //self.locationManager.stopUpdatingLocation()
        locality?.text = "\(placemark.locality)"
        
        postalCode?.text = "\(placemark.postalCode)"
        
        AdministrativeArea?.text = "\(placemark.administrativeArea)"
        
        country?.text = "\(placemark.country)"
        
        latitude?.text = "\(currentLocation.coordinate.latitude)"
        
        longitude?.text = "\(currentLocation.coordinate.longitude)"
        
    }
    
    
    func checkiflocationchanges(manager: CLLocationManager, didUpdateLocations locations: [CLLocation], placemark: CLPlacemark)
    {
        let distance =  currentLocation.distanceFromLocation(currentLocation);
        if(distance>10.0){
        self.performSegueWithIdentifier("s1", sender: self) //transitions from one screen to the next upon fulfilling the threshold value
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error: " + error.localizedDescription)
    }
    
    
}


