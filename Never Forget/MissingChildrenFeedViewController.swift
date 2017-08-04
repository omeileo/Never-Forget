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
    
    var missingChild = MissingChild(gender: Gender.female, firstName: "", lastName: "", age: 0, lastSeenAt: Address(district: "", parish: Parish.notStated), lastSeenDate: "Jun 21, 2017", missingStatus: MissingStatus.missing)
    
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
        if let missingChildrenRef = self.ref?.child("Missing Children")
        {
            missingChildrenRef.observe(.value, with: { (snapshot) in
                if let result = snapshot.children.allObjects as? [DataSnapshot]
                {
                    for child in result
                    {
                        
                        //print("Record: \(child.value!)")
                        
                        let missingChildInfo = child.value as? NSDictionary
                        self.missingChild.age = missingChildInfo?["Age"] as? Int16 ?? 0
                        self.missingChild.bodyType = missingChildInfo?["Body-Type"] as? BodyType ?? BodyType.other
                        self.missingChild.citizenship = missingChildInfo?["Citizenship"] as? String ?? ""
                        self.missingChild.complexion = missingChildInfo?["Complexion"] as? Complexion ?? Complexion.other
                        self.missingChild.eyeColor = missingChildInfo?["Eye-Color"] as? EyeColor ?? EyeColor.other
                        self.missingChild.firstName = missingChildInfo?["First-Name"] as? String ?? ""
                        self.missingChild.hairColor = missingChildInfo?["Hair-Color"] as? HairColor ?? HairColor.other
                        self.missingChild.hairType = missingChildInfo?["Hair-Type"] as? HairType ?? HairType.other
                        self.missingChild.height = missingChildInfo?["Height"] as? Double ?? 0.0
                        self.missingChild.lastName = missingChildInfo?["Last-Name"] as? String ?? ""
                        self.missingChild.lastSeenAt.district = missingChildInfo?["Last-Seen-Address-District"] as? String ?? ""
                        self.missingChild.lastSeenAt.parish = missingChildInfo?["Last-Seen-Address-Parish"] as? Parish ?? Parish.notStated
                        self.missingChild.nickname = missingChildInfo?["Nickname"] as? String ?? ""
                        self.missingChild.residingAddress?.district = missingChildInfo?["Residing-Address-District"] as? String ?? ""
                        self.missingChild.residingAddress?.parish = missingChildInfo?["Residing-Address-Parish"] as? Parish ?? Parish.notStated
                        self.missingChild.weight = missingChildInfo?["Weight"] as? Double ?? 0.0
                        
                        print("Child: \(self.missingChild)")
                    }
                }
            })
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

