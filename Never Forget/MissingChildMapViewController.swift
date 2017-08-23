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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationTitle.title = "\(missingChild.firstName) \(missingChild.lastName)"
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
