# 15th-August
About:
ViewController’s role is to detect a pre-quantified jerk and tilt using the iPhone’s accelerometer and gyroscope. 
If a jerk is recorded it shall activate ViewController2.

ViewController2’s function is to find the current location of the user. 
It is activated only when a jerk is recorded. 
The location (Street name, postal code, city etc. including latitude and longitude) are displayed on the screen.

N.B. There is a patent pending for this idea, please note this code is copyright protected.

Next steps: If the location keeps updating then the software will assume that there has been no major accident (maybe a violent brake only). 
If the location stops updating means there has been a jerk and the car is stationery- a cause of concern. 
It will then send the location to certain contacts that the user has already populated the directory with at an earlier point (before using the app).

Functional
Built using Xcode 7.1.1
