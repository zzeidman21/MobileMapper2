//
//  ViewController.swift
//  MobileMapper2
//
//  Created by Zachary Zeidman 2021 on 4/1/19.
//  Copyright © 2019 Zachary Zeidman 2021. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager( manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        currentLocation = locations[0]
    }
    
    @IBAction func zoomButtonTapped(_ sender: UIBarButtonItem) {
        
        
    }
    
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        
        
    }
    
}

