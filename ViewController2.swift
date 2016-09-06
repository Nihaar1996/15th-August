//
//  ViewController2.swift
//  15th August
//
//  Created by Apple on 15/08/15.
//  Copyright (c) 2015 nihaar. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI


class ViewController2: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate

    {//each outlet is connected to a text box on the screen
    
    @IBOutlet var locality: UILabel?
    @IBOutlet var postalCode: UILabel?
    @IBOutlet var AdministrativeArea: UILabel?
    @IBOutlet var country: UILabel?
    @IBOutlet var latitude: UILabel?
    @IBOutlet var longitude: UILabel?
    
    
//    @IBAction func doSomething(sender: UIButton)
//    {
//        self.performSegueWithIdentifier("s2", sender: self); //transitions from one screen to the next upon button pressing
//    }
    
    @IBAction func doSomethingelse(sender: UIButton)
    {
        self.performSegueWithIdentifier("home-cartrip", sender: self); //transitions from one screen to the next upon button pressing
    }
    
    @IBAction func doSomethingdifferent(sender: UIButton)
    {
        self.performSegueWithIdentifier("location-cartrip", sender: self); //transitions from one screen to the next upon button pressing
    }
    
    @IBAction func doSomethingmoredifferent(sender: UIButton)
    {
        self.performSegueWithIdentifier("sos", sender: self); //transitions from one screen to the next upon button pressing
    }
   
    @IBOutlet weak var cont: UITextView!
    
    
    @IBOutlet weak var NameofContact: UITextInput!
    
    @IBOutlet var num: UITextInput!
    
    var savedText: String!
    
    func textFieldShouldReturn(num: UITextField) -> Bool {
        savedText = num.text
        num.resignFirstResponder()
        return false
    }
    
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
    
    
    // Create a MessageComposer
    let messageComposer = MessageComposer()
    
    @IBAction func sendTextMessageButtonTapped(sender: UIButton) {
        // Make sure the device can send text messages
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            
            
            let textMessageRecipients = ["\(num)"] // for pre-populating the recipients list (optional, depending on your needs)
            messageComposeVC.recipients = textMessageRecipients
            messageComposeVC.body = "Hi \(NameofContact), This is Nihaar and i have met with a serious accident. Please help me. My location is longitude:\(currentLocation.coordinate.longitude), latitude: \(currentLocation.coordinate.latitude)"
//            , city: \(placemark.locality), state: \(placemark.administrativeArea), postal code: \(placemark.postalCode). This is generated by Must app."
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    
}


