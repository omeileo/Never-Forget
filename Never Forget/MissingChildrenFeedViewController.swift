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
import FirebaseStorage

class MissingChildrenFeedViewController: UIViewController
{
    @IBOutlet weak var neverForgetMissingChildrenCollectionView: UICollectionView!
    @IBOutlet weak var missingChildrenFeedTableView: UITableView!
    
    var databaseRef: DatabaseReference!
    
    var missingChildren = [MissingChild]()
    
    //table view
    let cellReuseIdentifier = "MissingChildCell"
    
    //collection view
    let reuserIdentifier = "NeverForgetMissingChildCell"
    //let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    
    let loginViewSegueIdentifier = "showLoginViewController"
    let addMissingChildViewSegueIdentifier = "showAddMissingChildViewController"
    let viewMissingChildProfileSegueIdentifier = "showMissingChildViewController"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //setup tableview delegate and datasource
        missingChildrenFeedTableView.delegate = self
        missingChildrenFeedTableView.dataSource = self
        
        //setup collectionview delegate and datasource
        neverForgetMissingChildrenCollectionView.delegate = self
        neverForgetMissingChildrenCollectionView.dataSource = self
        
        databaseRef = Database.database().reference()
        let storageRef = Storage.storage().reference().child("Missing Children Photos")
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //listen for new missing children in Firebase database
        if let missingChildrenRef = self.databaseRef?.child("Missing Children")
        {
            missingChildrenRef.observe(.childAdded, with: {(snapshot) in
                if let missingChildDictionary = snapshot.value as? [String: AnyObject]
                {
                    var missingChild = MissingChild(gender: Gender.female, firstName: "", lastName: "", age: 0, lastSeenAt: Address(district: "", parish: Parish.notStated), lastSeenDate: "Jun 21, 2017", missingStatus: MissingStatus.missing)
                    
                    let bodyType = missingChildDictionary["bodyType"] as? String ?? "Other"
                    let complexion = missingChildDictionary["complexion"] as? String ?? "Other"
                    let eyeColor = missingChildDictionary["eyeColor"] as? String ?? "Other"
                    let gender = missingChildDictionary["gender"] as? String ?? "Female"
                    let hairColor = missingChildDictionary["hairColor"] as? String ?? "Other"
                    let hairType = missingChildDictionary["hairType"] as? String ?? "Other"
                    let lastSeenAddressParish = missingChildDictionary["lastSeenAddressParish"] as? String ?? "notStated"
                    let residingAddressParish = missingChildDictionary["residingAddressParish"] as? String ?? "notStated"
                    
                    missingChild.age = missingChildDictionary["age"] as? Int16 ?? 0
                    missingChild.bodyType = BodyType(rawValue: bodyType)
                    missingChild.citizenship = missingChildDictionary["citizenship"] as? String
                    missingChild.complexion = Complexion(rawValue: complexion)
                    missingChild.eyeColor = EyeColor(rawValue: eyeColor)
                    missingChild.firstName = missingChildDictionary["firstName"] as? String ?? ""
                    missingChild.gender = Gender(rawValue: gender)!
                    missingChild.hairColor = HairColor(rawValue: hairColor)
                    missingChild.hairType = HairType(rawValue: hairType)
                    missingChild.height = missingChildDictionary["height"] as? Double ?? 0.0
                    missingChild.lastName = missingChildDictionary["lastName"] as? String ?? ""
                    missingChild.lastSeenAddressDistrict = missingChildDictionary["lastSeenAddressDistrict"] as? String ?? ""
                    missingChild.lastSeenAddressParish = Parish(rawValue: lastSeenAddressParish)!
                    missingChild.lastSeenDateString = missingChildDictionary["lastSeenDate"] as? String ?? ""
                    missingChild.nickname = missingChildDictionary["nickname"] as? String ?? ""
                    missingChild.residingAddressDistrict = missingChildDictionary["residingAddressDistrict"] as? String ?? ""
                    missingChild.residingAddressParish = Parish(rawValue: residingAddressParish)!
                    missingChild.weight = missingChildDictionary["weight"] as? Double ?? 0.0
                    
                    missingChild = self.retrieveMissingChildPhotos(child: missingChild)
                    
                    self.missingChildren.append(missingChild)
                    
                    DispatchQueue.main.async
                    {
                        self.missingChildrenFeedTableView.reloadData()
                        self.neverForgetMissingChildrenCollectionView.reloadData()
                    }
                    
                    let reference = storageRef.child(snapshot.key)
                    //print(reference)
                    
                    
                }
            }, withCancel: nil)
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

