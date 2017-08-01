//
//  FirstViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/20/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MissingChildrenFeedViewController: UIViewController
{
    let loginViewSegueIdentifier = "showLoginViewController"
    let addMissingChildViewSegueIdentifier = "showAddMissingChildViewController"
    
    override func viewWillAppear(_ animated: Bool)
    {
<<<<<<< HEAD
        super.viewDidLoad()
=======
        super.viewWillAppear(animated)
        
>>>>>>> navigation-bar-experimenting
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

