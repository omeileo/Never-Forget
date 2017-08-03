//
//  FirstViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/20/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class MissingChildrenFeedViewController: UIViewController
{
    @IBOutlet weak var missingChildrenFeedTableView: UITableView!
    
    var ref: DatabaseReference!
    
    var missingChildren = [MissingChild]()
    let cellReuseIdentifier = "MissingChildCell"
    let loginViewSegueIdentifier = "showLoginViewController"
    let addMissingChildViewSegueIdentifier = "showAddMissingChildViewController"
    let viewMissingChildProfileSegueIdentifier = "showMissingChildViewController"
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        ref = Database.database().reference()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //listen for new missing children in Firebase database
        if let missingChildRef = self.ref?.child("Missing Children")
        {
//            missingChildRef.observeSingleEvent(of: .value, with: { snapshot in
//                for child in snapshot.children
//                {
//                    if let age = child.value["Age"] as! String
//                    {
//                        
//                    }
//                }
//            })
            
            
        }

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

