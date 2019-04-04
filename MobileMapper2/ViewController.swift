//
//  ViewController.swift
//  MobileMapper2
//
//  Created by Zachary Zeidman 2021 on 4/1/19.
//  Copyright © 2019 Zachary Zeidman 2021. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    
    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation!
    
    var parks: [MKMapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print(currentLocation)
        currentLocation = locations[0]
        
    }
    
    @IBAction func zoomButtonTapped(_ sender: UIBarButtonItem) {
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center = currentLocation.coordinate
        let region = MKCoordinateRegion(center: center, span: coordinateSpan)
        mapView.setRegion(region, animated: true)
        
    }
    
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Parks"
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else { return }
            
            for mapItem in response.mapItems{
                self.parks.append(mapItem)
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
            }
        
            
        }
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isEqual(mapView.userLocation){
            return nil
        }
        func mapView(_ mapView: MKMapView, annotationView view: MKMapView, calloutAccessoryControlTapped control: UIControl)
        {
            var currentMapItem = MKMapItem()
            
            if let title = view.annotation?.title, let parkName = title
            {
                for mapItem in parks{
                    if mapItem.name  == parkName
                        {
                        currentMapItem = mapItem
                        }
                }
            }
            let placemark = currentMapItem.placemark
            print(placemark)
        }

        var pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
            if let title = annotation.title, let actualTitle = title {
                if actualTitle == "Franco Park" {
                    pin.image = UIImage(named: "MobileMakerIconPinImage")
                } else {
                    pin  = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
                }
            }
        
    
//        let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
//        pin.image = UIImage(named: "MobileMakerIconPinImage")
//        pin.canShowCallout = true
//        let button = UIButton(type: .detailDisclosure)
//        pin.rightCalloutAccessoryView = button
        return pin
    }
    
}

