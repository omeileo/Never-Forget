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
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    override func viewDidLoad()
    {
        navigationTitle.title = "Testing"
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
