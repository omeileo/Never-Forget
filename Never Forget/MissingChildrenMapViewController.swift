//
//  MissingChildrenMapViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/20/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftKeychainWrapper

class MissingChildrenMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    @IBOutlet weak var missingChildrenMapView: MKMapView!
    @IBOutlet weak var missingChildrenCollectionView: UICollectionView!
    
    var locationManager = CLLocationManager()
    var userLocation: MKCoordinateRegion?
    var annotations = [MKAnnotation]()
    
    let loginViewSegueIdentifier = "showLoginViewController"
    let addMissingChildViewSegueIdentifier = "showAddMissingChildViewController"
    
    let cellReuseIdentifier = "MissingChildCell"
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        missingChildrenMapView.showsUserLocation = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        missingChildrenMapView.showsUserLocation = false
    }
    
    func setup()
    {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setupMapView()
        setupLocation()
        setupMissingChildrenData()
    }
    
    func setupMapView()
    {
        missingChildrenMapView.delegate = self
        missingChildrenMapView.mapType = .standard
    }
    
    func setupLocation()
    {
        //check for location services
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            
            locationManager.startUpdatingLocation()
        }
        
        if let coordinates = missingChildrenMapView.userLocation.location?.coordinate
        {
            missingChildrenMapView.setCenter(coordinates, animated: true)
        }
    }
    
    func setupMissingChildrenData()
    {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let identifier = "pin"
        var customPinView: MKPinAnnotationView?
        
        if let dequeuView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        {
            dequeuView.annotation = annotation
            customPinView = dequeuView
        }
        else
        {
            customPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        if let customPinView = customPinView
        {
            customPinView.image = UIImage(named: "location-pin-2")
        }
        return customPinView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locationValue: CLLocationCoordinate2D = manager.location!.coordinate
        
        centerMap(locationValue)
    }
    
    func centerMap(_ center: CLLocationCoordinate2D)
    {
        let spanX = 0.03
        let spanY = spanX
        
        let newRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: spanX, longitudeDelta: spanY))
        missingChildrenMapView.setRegion(newRegion, animated: true)
    }

    @IBAction func reportMissingChild(_ sender: UIBarButtonItem)
    {
        if let _ = KeychainWrapper.standard.string(forKey: "neverForgetUserEmail"), let _ = KeychainWrapper.standard.string(forKey: "neverForgetUserPassword")
        {
            performSegue(withIdentifier: addMissingChildViewSegueIdentifier, sender: self)
        }
        else
        {
            performSegue(withIdentifier: loginViewSegueIdentifier, sender: self)
        }
    }
    
}

