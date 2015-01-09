//
//  ViewController.swift
//  Where am i
//
//  Created by Talha Qamar on 1/10/15.
//  Copyright (c) 2015 Talha Qamar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate  {

    @IBOutlet var latlng: UILabel!
    @IBOutlet var course: UILabel!
    @IBOutlet var speed: UILabel!
    @IBOutlet var altitude: UILabel!
    @IBOutlet var address: UILabel!
    
    @IBOutlet var mymap: MKMapView!
    var manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       initialize()
        
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        // manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        
    
    }
    func initialize()
    {
    
        latlng.text = ""
        course.text = ""
        speed.text = ""
        altitude.text = ""
        address.text = ""
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    {
        var userlocation:CLLocation = locations[0] as CLLocation
        var lat:CLLocationDegrees = userlocation.coordinate.latitude
        var lon:CLLocationDegrees = userlocation.coordinate.longitude
        CLGeocoder().reverseGeocodeLocation(userlocation,completionHandler:{(placemarks,error) in
            if(error != nil){println(error)}
            else { let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                self.address.text = "\(p.postalCode) \(p.country)"}
        })
        self.latlng.text = "\(userlocation.coordinate.latitude) / \(userlocation.coordinate.longitude)"
        
        self.course.text = "\(userlocation.course)"
        self.speed.text = "\(userlocation.speed)"
        self.altitude.text = "\(userlocation.altitude)"
        
        var ladelta : CLLocationDegrees = 0.01
        var lndelta : CLLocationDegrees = 0.01
        
        var s:MKCoordinateSpan = MKCoordinateSpanMake(ladelta,lndelta)
        var l:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
        var reg:MKCoordinateRegion = MKCoordinateRegionMake(l, s)
        mymap.setRegion(reg, animated: true)
        var annotation = MKPointAnnotation()
        annotation.coordinate = l
        annotation.title = "Your location"
        annotation.subtitle = "Its your location dude ..."
        
        mymap.addAnnotation(annotation)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}