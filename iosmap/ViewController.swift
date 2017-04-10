//
//  ViewController.swift
//  iosmap
//
//  Created by Grady Nobles on 4/8/17.
//  Copyright © 2017 Grady Nobles. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


var myTrip: [CLLocationCoordinate2D] = []

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    //Location Attribute
    var locationManager = CLLocationManager()

    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor(red: 0.5569, green: 0.6431, blue: 0.8235, alpha: 1.0) /* #8ea4d2 */
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return MKPolylineRenderer()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.delegate = self
        
        
        //Users Location grab
        
       locationManager.delegate = self
        //Accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //granting Authorization
        locationManager.requestAlwaysAuthorization()
        //updating to user's location
        locationManager.startUpdatingLocation()
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let latitude:CLLocationDegrees = 40.672640
        
        
        let longitude:CLLocationDegrees = -111.942339
        
        // the difference of lat and long from side to side of screen
        
        let latDelta:CLLocationDegrees = 0.8
        
        let lonDelta:CLLocationDegrees = 0.8
        
        //lat and long zoom
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        // Lat and lon of the map
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        //Make the region
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        
        //map to region
        map.setRegion(region, animated: true)
        
        //track
        
        myTrip.append(location)
        //print route form array
        let myTripPolyline = MKPolyline(coordinates: &myTrip, count: myTrip.count)
        
        self.map.add(myTripPolyline)
        
        //adding annotations
        
        let annotation = MKPointAnnotation()
        
        //annotation objects and properties
        annotation.coordinate = location
        
        annotation.title = "Salt Lake"
        
        annotation.subtitle = "CSIS class"
        
        
        map.addAnnotation(annotation)
        
       //Long Press
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector( "action:"))
        
        //must hold for this long
        longPress.minimumPressDuration = 2
        
        //add to map
        map.addGestureRecognizer(longPress)
        
    }
    
    //long press function
    func action(theLongPress:UIGestureRecognizer)
    {
    print ("stop that")
    
        let userTouch = theLongPress.location(in: self.map)
        
        let userCoordinate: CLLocationCoordinate2D = map.convert(userTouch, toCoordinateFrom: self.map)
        
        //adding annotations
        
        let annotation = MKPointAnnotation()
        
        //annotation objects and properties
        annotation.coordinate = userCoordinate
        
        annotation.title = "Trip 1"
        
        annotation.subtitle = "Cool place"
        
        map.addAnnotation(annotation)
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
    print(locations)
        
        // blue dot for user location
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

