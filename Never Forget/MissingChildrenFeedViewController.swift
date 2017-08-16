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
    var missingChild: MissingChild!
    
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
        
        var count = 0
        
        //listen for new missing children in Firebase database
        if let missingChildrenRef = self.databaseRef?.child("Missing Children")
        {
            missingChildrenRef.observe(.childAdded, with: {(snapshot) in
                if let missingChildDictionary = snapshot.value as? [String: AnyObject]
                {
                    var missingChild = MissingChild(gender: Gender.female, firstName: "", lastName: "", age: 0, lastSeenAt: Address(district: "", parish: Parish.notStated), lastSeenDate: "Jan 1, 2000", missingStatus: MissingStatus.missing)
                    
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
                    missingChild.lastSeenDateString = missingChildDictionary["lastSeenDate"] as? String ?? "Jan 1, 2000"
                    missingChild.nickname = missingChildDictionary["nickname"] as? String ?? ""
                    missingChild.residingAddressDistrict = missingChildDictionary["residingAddressDistrict"] as? String ?? ""
                    missingChild.residingAddressParish = Parish(rawValue: residingAddressParish)!
                    missingChild.weight = missingChildDictionary["weight"] as? Double ?? 0.0
                    
                    missingChild.ID = snapshot.key
                    missingChild.profilePictureURL = missingChildDictionary["profilePictureURL"] as? String ?? ""
                    
                    DispatchQueue.main.async
                    {
                        self.retrieveMissingChildPhotos(child: missingChild) { image in
                            print(image)
                            missingChild.profilePicture = image
                            
                            self.missingChildren.append(missingChild)
                            
                            self.missingChildrenFeedTableView.reloadData()
                            self.neverForgetMissingChildrenCollectionView.reloadData()
                        }
                        
//                        do
//                        {
//                            if missingChild.profilePictureURL != "", let url = URL(string: missingChild.profilePictureURL!)
//                            {
//                                let imageDate = try Data(contentsOf: url)
//                                missingChild.profilePicture = UIImage(data: imageDate)!
//                            }
//                            else
//                            {
//                                missingChild.profilePicture = UIImage(named: missingChild.gender.rawValue)!
//                            }
//                        }
//                        catch let error
//                        {
//                            print(error)
//                        }
//
                    }
                }
            }, withCancel: nil)
        }
    }
    
    func retrieveMissingChildPhotos(child: MissingChild, completion: @escaping (UIImage) -> ())
    {
        let storageRef = Storage.storage().reference().child("Missing Children Photos")
        
        var image = UIImage(named: child.gender.rawValue)
        let imageName = "\(child.ID!)/\(child.ID!)-0.jpg"
        print(imageName)
        let photoRef = storageRef.child(imageName)
        
        photoRef.getData(maxSize: 5 * 1024 * 1024, completion: { (data, error) in
            if let error = error
            {
                print(error.localizedDescription)
                
                image = UIImage(named: child.gender.rawValue)!
                print(child.gender)
                completion(image!)
            }
            else
            {
                image = UIImage(data: data!)!
                completion(image!)
                print(child.gender)
                print("\(imageName) has been downloaded.")
            }
        })
    }
    
    func retrieveMissingChildrenProfilePictures()
    {
        let storageRef = Storage.storage().reference().child("Missing Children Photos")
        print("Number of children: \(missingChildren.count)")
        
        for count in 0..<missingChildren.count
        {
            let imageName = "\(missingChildren[count].ID!)/\(missingChildren[count].ID!)-0.jpg"
            let photoRef = storageRef.child(imageName)
            print(imageName)
            
            photoRef.getData(maxSize: 5 * 1024 * 1024, completion: { (data, error) in
                if let error = error
                {
                    print(error.localizedDescription)
                    
                    self.missingChildren[count].profilePicture = UIImage(named: self.missingChildren[count].gender.rawValue)!
                }
                else
                {
                    self.missingChildren[count].profilePicture = UIImage(data: data!)!
                }
            })
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

