//
//  ViewController.swift
//  zadanie3
//
//  Created by Adrianna Ryś on 05.11.2016.
//  Copyright © 2016 ada. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var myMap: MKMapView!
    var location: CLLocationManager!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopBtn.isEnabled = false
        if (CLLocationManager.locationServicesEnabled())
        {
            location = CLLocationManager()
            location.delegate = self
            location.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startBtnClicked(_ sender: UIButton) {
        startBtn.isEnabled = false
        stopBtn.isEnabled = true
        
        location.startUpdatingLocation()
        myMap.showsUserLocation = true
        
    }

    @IBAction func clearBtnClicked(_ sender: UIButton) {
        myMap.removeAnnotations(myMap.annotations)
    }
    
    @IBAction func stopBtnClicked(_ sender: UIButton) {
        startBtn.isEnabled = true
        stopBtn.isEnabled = false
        
        location.stopUpdatingLocation()
        myMap.showsUserLocation = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation = locations.last!.coordinate
        let locationMarker = MKPointAnnotation()
        let lastLocation = locations[locations.count-1] as CLLocation
        
        locationMarker.coordinate = currentLocation
        myMap.addAnnotation(locationMarker)
        centerOnNewLocation(location: lastLocation, regionRadius: 25 + lastLocation.speed*50)
        print(lastLocation.speed)
    }
    
    func centerOnNewLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        myMap.setRegion(coordinateRegion, animated: true)
    }
}

