//
//  Missing Child Map View Controller.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/10/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import MapKit

class MissingChildMapViewController: UIViewController
{
    @IBOutlet weak var missingChildMapView: MKMapView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    let missingChildProfileViewSegueIdentifier = "showMissingChildProfile"
    
    var missingChild: MissingChild!
    
    var localSearchRequest: MKLocalSearchRequest!
    var localSearch: MKLocalSearch!
    var localSeachResponse: MKLocalSearchResponse!
    var annotation: MKAnnotation!
    var pointAnnotation: MKPointAnnotation!
    var pinAnnotationView: MKPinAnnotationView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationTitle.title = "\(missingChild.firstName) \(missingChild.lastName)"
        placeMissingChildLastSeenLocationOnMap()
    }
    
    func placeMissingChildLastSeenLocationOnMap()
    {
        let missingChildLastSeenLocation = "\(missingChild.lastSeenAddressDistrict), \(missingChild.lastSeenAddressParish.rawValue)"
        
        if self.missingChildMapView.annotations.count != 0
        {
            annotation = self.missingChildMapView.annotations[0]
            self.missingChildMapView.removeAnnotation(annotation)
        }
        
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = "\(missingChildLastSeenLocation), Jamaica"
        
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) in
            if localSearchResponse == nil
            {
                self.showAlert(title: nil, message: "Address Could Not Be Found on Map", action: "Dismiss")
                return
            }
            
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = missingChildLastSeenLocation
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.pinAnnotationView.image = UIImage(named: "location-pin")
            
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(self.pointAnnotation.coordinate, 1000, 1000)
            self.missingChildMapView.setRegion(coordinateRegion, animated: true)
            self.missingChildMapView.addAnnotation(self.pinAnnotationView.annotation!)
            self.missingChildMapView.selectAnnotation(self.missingChildMapView.annotations[0], animated: true)
        }
    }
    
    @IBAction func goBack(_ sender: Any)
    {
        performSegue(withIdentifier: missingChildProfileViewSegueIdentifier, sender: missingChild)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == missingChildProfileViewSegueIdentifier
        {
            if let missingChildProfileViewController = segue.destination as? MissingChildProfileViewController, let missingChild = sender as? MissingChild
            {
                missingChildProfileViewController.missingChild = missingChild
            }
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
