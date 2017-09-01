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
import FirebaseDatabase
import SwiftKeychainWrapper

class MissingChildrenMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    @IBOutlet weak var missingChildrenMapView: MKMapView!
    @IBOutlet weak var missingChildrenCollectionView: UICollectionView!
    
    var locationManager = CLLocationManager()
    var userLocation: MKCoordinateRegion?
    var annotations = [MKAnnotation]()
    var localSearchRequest: MKLocalSearchRequest!
    var localSearch: MKLocalSearch!
    var localSearchResponse: MKLocalSearchResponse!
    var pointAnnotation: MKPointAnnotation!
    var pinAnnotationView: MKPinAnnotationView!
    
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
        missingChildrenMapView.showsUserLocation = true
    }
    
    func setup()
    {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.missingChildrenCollectionView.delegate = self
        self.missingChildrenCollectionView.dataSource = self
        
        setupMapView()
        setupLocation()
        placeMissingChildrenOnMap()
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
    
    func placeMissingChildrenOnMap()
    {
        //clear the annotations that might have been on the map
        var count = 0
        while self.missingChildrenMapView.annotations.count != 0
        {
            let annotation = self.missingChildrenMapView.annotations[count]
            self.missingChildrenMapView.removeAnnotation(annotation)
            count += 1
        }
        
        count = 0
        
        for child in missingChildren
        {
            let location = "\(child.lastSeenAddressDistrict), \(child.lastSeenAddressParish.rawValue), Jamaica"
            
            localSearchRequest = MKLocalSearchRequest()
            localSearchRequest.naturalLanguageQuery = location
            localSearch = MKLocalSearch(request: localSearchRequest)
            localSearch.start(completionHandler: { (localSearchResponse, error) in
                if localSearchResponse != nil
                {
                    self.pointAnnotation = MKPointAnnotation()
                    self.pointAnnotation.title = "\(child.firstName) \(child.lastName[child.lastName.index(child.lastName.startIndex, offsetBy: 0)])."
                    self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
                    
                    self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
                    
                    self.missingChildrenMapView.addAnnotation(self.pinAnnotationView.annotation!)
                    self.missingChildrenMapView.selectAnnotation(self.missingChildrenMapView.annotations[count], animated: true)
                    
                    count += 1
                }
                else
                {
                    print(error?.localizedDescription ?? "")
                }
            })
        }
        
//        self.missingChildrenMapView.showAnnotations(self.missingChildrenMapView.annotations, animated: true)
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

