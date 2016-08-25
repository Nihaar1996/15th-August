//
//  ViewController.swift
//  15th August
//
//  Created by Apple on 15/08/15.
//  Copyright (c) 2015 nihaar. All rights reserved.
//  Edit: Will take this further now 08/24/16


import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    //Instance Variables
    //Obtains the current value of acceleration in each axis
    var currentMaxAccelX: Double = 0.0
    var currentMaxAccelY: Double = 0.0
    var currentMaxAccelZ: Double = 0.0
    
    var currentMaxRotX: Double = 0.0
    var currentMaxRotY: Double = 0.0
    var currentMaxRotZ: Double = 0.0
    //Creates an array with two spaces
    var accelArrayX = [Double](count: 2, repeatedValue: 0.0)
    var accelArrayY = [Double](count: 2, repeatedValue: 0.0)
    var accelArrayZ = [Double](count: 2, repeatedValue: 0.0)
    var isFirstValue = true              //Boolean to determine if there has been an input in the first space of array
    var deltaAcceleration: Double = 1.0        //this is the threshold acceleration difference;
    
    var motionManager = CMMotionManager()
    
    @IBOutlet var AccX: UILabel?
    @IBOutlet var AccY: UILabel?
    @IBOutlet var AccZ: UILabel?
    @IBOutlet var maxAccX: UILabel?
    @IBOutlet var maxAccY: UILabel?
    @IBOutlet var maxAccZ: UILabel?
    @IBOutlet var RotX: UILabel?
    @IBOutlet var RotY: UILabel?
    @IBOutlet var RotZ: UILabel?
    @IBOutlet var MaxRotX: UILabel?
    @IBOutlet var MaxRotY: UILabel?
    @IBOutlet var MaxRotZ: UILabel?
    @IBOutlet var Alert: UILabel?
    
    
    
    //Functions
    
    @IBAction func resetMaxValues (){
        
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
        
    }
    
    
    override func viewDidLoad() {
        
        
        self.resetMaxValues ()
        
        
        //Set motion manager properties
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
        //Start Recording Data
        
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!,
            withHandler: { (accelerometerData, error) -> Void
                in
                if (accelerometerData != nil)
                {
                self.outputAccelerationData (accelerometerData!.acceleration)
                }
                if (error != nil)
                {
                    print("\(error)")
                }
        })
        
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!,
            withHandler: { (gyroData, error) -> Void
                in
                if (gyroData != nil)
                {
                    self.outputRotationData(gyroData!.rotationRate)
                }
                if (error != nil)
                {
                    print("\(error)")
                }
        })
        super.viewDidLoad()
        
        
        //Do any additional setup after loading the view, typically from a nib.
    }
    func outputAccelerationData(acceleration:CMAcceleration) {
        
        //creating an array conatining accelerometer data from consecutive timestamps; (in each axis)
        
        if self.isFirstValue == true {
            accelArrayX[0] = acceleration.x
            accelArrayY[0] = acceleration.y
            accelArrayZ[0] = acceleration.z
            isFirstValue = false
        } else {
            accelArrayX[1] = accelArrayX[0]
            accelArrayX[0] = acceleration.x
            accelArrayY[1] = accelArrayY[0]
            accelArrayY[0] = acceleration.y
            accelArrayZ[1] = accelArrayZ[0]
            accelArrayZ[0] = acceleration.z
             
            //comparing the change in acceleration (denoted by difference in two consecutive acceleration values) to the predefined threshold of "deltaAcceleration")
            
            if (abs (accelArrayX[0] - accelArrayX[1]) > deltaAcceleration || abs (accelArrayY[0] - accelArrayY[1]) > deltaAcceleration || abs (accelArrayZ[0] - accelArrayZ[1]) > deltaAcceleration)  //add a speed parameter with AND logic
            {
                Alert?.text = "DANGER?"
                self.performSegueWithIdentifier("s1", sender: self) //transitions from one screen to the next upon fulfilling the threshold value
                
                
            }
        }
        //prints the maximum acceleration value; compares and replaces the current value with every new value that is greater than the previous maximum
        
        AccX?.text = "\(acceleration.x).2fg"
        if fabs(acceleration.x) > fabs(currentMaxAccelX)
        {
            currentMaxAccelX = acceleration.x
        }
        
        AccY?.text = "\(acceleration.y).2fg"
        if fabs(acceleration.y) > fabs(currentMaxAccelY)
        {
            currentMaxAccelY = acceleration.y
        }
        
        AccZ?.text = "\(acceleration.z).2fg"
        if fabs(acceleration.z) > fabs(currentMaxAccelZ)
        {
            currentMaxAccelZ = acceleration.z
        }
        
        
        maxAccX?.text = "\(currentMaxAccelX) .2f"
        maxAccY?.text = "\(currentMaxAccelY) .2f"
        maxAccZ?.text = "\(currentMaxAccelZ) .2f"
    }
    
    
    
    
    //Performs similar comparision from gyroscope data; replaces previous max. value with new one after comparing each new datum
    
    func outputRotationData(rotation: CMRotationRate) {
        RotX?.text = "\(rotation.x).2fr/s"
        
        if fabs(rotation.x) > fabs(currentMaxRotX)
        {
            currentMaxRotX = rotation.x
        }
        
        
        RotY?.text = "\(rotation.y).2fr/s"
        if fabs(rotation.y) > fabs(currentMaxRotY)
        {
            currentMaxRotY = rotation.y
        }
        
        
        RotZ?.text = "\(rotation.z).2fr/s"
        if fabs(rotation.z) > fabs(currentMaxRotZ)
        {
            currentMaxRotZ = rotation.z
        }
        
        
        MaxRotX?.text = "\(currentMaxRotX) .2f"
        MaxRotY?.text = "\(currentMaxRotY) .2f"
        MaxRotZ?.text = "\(currentMaxRotZ) .2f"
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

