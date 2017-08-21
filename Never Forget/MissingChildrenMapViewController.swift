//
//  MissingChildrenMapViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/20/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import MapKit
import SwiftKeychainWrapper

class MissingChildrenMapViewController: UIViewController
{
    @IBOutlet weak var missingChildrenMapView: MKMapView!
    
    var locationManager = CLLocationManager()
    let loginViewSegueIdentifier = "showLoginViewController"
    let addMissingChildViewSegueIdentifier = "showAddMissingChildViewController"
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        setup();
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup()
    {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setupMapView();
        setupLocation();
    }
    
    func setupMapView()
    {
        missingChildrenMapView.delegate = self as? MKMapViewDelegate
        missingChildrenMapView.showsUserLocation = true
    }
    
    func setupLocation()
    {
        //check for location services
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.startUpdatingLocation()
        }
        
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

