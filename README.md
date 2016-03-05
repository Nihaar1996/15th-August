# Road Accident Locator App
About:
ViewController’s role is to detect a pre-quantified jerk and tilt angle using the iPhone’s accelerometer and gyroscope. 
If a jerk is recorded it shall activate ViewController2. 

ViewController2’s function is to find the current location of the user. 
It is activated only when a jerk is recorded. 
The location (Street name, postal code, city etc. including latitude and longitude) are displayed on the screen.

Next steps: 
If the location keeps changing then the software will assume that there has been no major accident (maybe a violent brake only after which the driver has moved on). 
If the location stops changing means there has been a jerk and the car is stationery- a cause of concern. 
It will then send the location to certain contacts that the user has already populated the app's directory with at an earlier point. Help will thus be on its way. There will be a manual terminate button so that the user can prevent a false alarm within a specified time after the accident was detected.

N.B. There is a patent pending for the implementation of this idea

Functional
Built using Xcode 7.1.1
