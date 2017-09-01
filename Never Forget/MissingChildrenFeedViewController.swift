//
//  MissingChildrenFeedViewController
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/20/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
import FirebaseStorage

var missingChildCache = NSCache<NSString, MissingChild>()
var missingChildProfilePictureCache = NSCache<NSString, UIImage>()
var missingChildren = [MissingChild]()

class MissingChildrenFeedViewController: UIViewController
{
    @IBOutlet weak var neverForgetMissingChildrenCollectionView: UICollectionView!
    @IBOutlet weak var missingChildrenFeedTableView: UITableView!
    
    var databaseRef: DatabaseReference!
    
//    var missingChildren = [MissingChild]()
    var missingChildrenNeverForget = [MissingChild]()
    var missingChild: MissingChild!
    let numberOfMonthsForNeverForgetView = 5
    
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
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //listen for new missing children in Firebase database
        retrieveMissingChildren()
    }
    
    func retrieveMissingChildren()
    {
        if let missingChildrenRef = self.databaseRef?.child("Missing Children")
        {
            missingChildrenRef.observe(.value, with: {(snapshot) in
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                {
                    for snap in snapshot
                    {
                        if let missingChildDictionary = snap.value as? [String: AnyObject]
                        {
                            let missingChild = MissingChild(gender: Gender.female, firstName: "", lastName: "", age: 0, lastSeenAt: Address(district: "", parish: Parish.notStated), lastSeenDate: "Jan 1, 2000", missingStatus: MissingStatus.missing)
                            
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
                            missingChild.convertToDate(dateString: missingChild.lastSeenDateString)
                            missingChild.nickname = missingChildDictionary["nickname"] as? String ?? ""
                            missingChild.residingAddressDistrict = missingChildDictionary["residingAddressDistrict"] as? String ?? ""
                            missingChild.residingAddressParish = Parish(rawValue: residingAddressParish)!
                            missingChild.weight = missingChildDictionary["weight"] as? Double ?? 0.0
                            
                            missingChild.ID = snap.key
                            missingChild.profilePictureURL = missingChildDictionary["profilePictureURL"] as? String ?? ""
                            missingChild.profilePicture = UIImage(named: missingChild.gender.rawValue)!
                            
                            if let image = missingChildProfilePictureCache.object(forKey: missingChild.ID! as NSString)
                            {
                                missingChild.profilePicture = image
                            }
                            else
                            {
                                self.retrieveMissingChildProfilePicture(child: missingChild) { image in
                                    missingChild.profilePicture = image
                                    missingChildProfilePictureCache.setObject(missingChild.profilePicture, forKey: missingChild.ID! as NSString)
                                    
                                    DispatchQueue.main.async
                                    {
                                            self.missingChildrenFeedTableView.reloadData()
                                            self.neverForgetMissingChildrenCollectionView.reloadData()
                                    }
                                }
                            }
                            
                            if missingChildCache.object(forKey: missingChild.ID! as NSString) == nil
                            {
                                missingChildCache.setObject(missingChild, forKey: missingChild.ID! as NSString)
                                missingChildren.append(missingChild)
                            }
                        }
                    }
                    
                    missingChildren.sort(by: {$0.lastSeenDate.compare($1.lastSeenDate) == .orderedDescending})
                    
                    self.missingChildrenNeverForget = missingChildren
                    
                    let neverForgetTimeInterval: TimeInterval = Double(self.numberOfMonthsForNeverForgetView * (60 * 60 * 24 * 30))
                    var count = 0
                    var indexesToBeRemoved: [Int] = []
                    
                    while !self.missingChildrenNeverForget.isEmpty
                    {
                        let child = self.missingChildrenNeverForget[count]
                        
                        if child.lastSeenDate.timeIntervalSinceNow.magnitude.isLess(than: neverForgetTimeInterval)
                        {
                            indexesToBeRemoved.append(count)
                            //print("X \(child.firstName): \(child.lastSeenDate.timeIntervalSinceNow.magnitude / (60 * 60 * 24)) days")
                        }
                        else
                        {
                            break
                        }
                        
                        count += 1
                    }
                    
                    // Remove missing children who have not been missing for over 5 months
                    self.missingChildrenNeverForget.removeSubrange(indexesToBeRemoved.startIndex..<indexesToBeRemoved.endIndex)
                    
                    //self.missingChildrenNeverForget.sort(by: {$0.lastSeenDate.compare($1.lastSeenDate) == .orderedAscending})
                    self.missingChildrenNeverForget.shuffle()
                }
                
                DispatchQueue.main.async
                {
                        self.missingChildrenFeedTableView.reloadData()
                        self.neverForgetMissingChildrenCollectionView.reloadData()
                }
            }, withCancel: nil)
        }
    }
    
    func _retrieveMissingChildren()
    {
        if let missingChildrenRef = self.databaseRef?.child("Missing Children")
        {
            missingChildrenRef.observe(.childAdded, with: {(snapshot) in
                if let missingChildDictionary = snapshot.value as? [String: AnyObject]
                {
                    let missingChild = MissingChild(gender: Gender.female, firstName: "", lastName: "", age: 0, lastSeenAt: Address(district: "", parish: Parish.notStated), lastSeenDate: "Jan 1, 2000", missingStatus: MissingStatus.missing)
                    
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
                    
                    self.retrieveMissingChildProfilePicture(child: missingChild) { image in
                        missingChild.profilePicture = image
                        
                        self.missingChildrenFeedTableView.reloadData()
                        self.neverForgetMissingChildrenCollectionView.reloadData()
                    }
                    
                    missingChildren.append(missingChild)
                }
            }, withCancel: nil)
            
            missingChildren = missingChildren.sorted(by: {$0.lastSeenDate.compare($1.lastSeenDate) == .orderedDescending})
        }
    }
    
    func retrieveMissingChildProfilePicture(child: MissingChild, completion: @escaping (UIImage) -> ())
    {
        let storageRef = Storage.storage().reference().child("Missing Children Photos")
        
        var image = UIImage(named: child.gender.rawValue)
        let imageName = "\(child.ID!)/\(child.ID!)-0.jpg"
        let photoRef = storageRef.child(imageName)
        
        photoRef.getData(maxSize: 5 * 1024 * 1024, completion: { (data, error) in
            if let error = error
            {
                print(error.localizedDescription)
                
                image = UIImage(named: child.gender.rawValue)!
            }
            else
            {
                image = UIImage(data: data!)!
            }
            
            completion(image!)
        })
    }
    
    func retrieveMissingChildProfilePicture_2(child: MissingChild, completion: @escaping (UIImage) -> ())
    {
        do
        {
            var image: UIImage!
            
            if child.profilePictureURL != "", let url = URL(string: child.profilePictureURL!)
            {
                let imageDate = try Data(contentsOf: url)
                image = UIImage(data: imageDate)!
            }
            else
            {
                image = UIImage(named: child.gender.rawValue)!
            }
            
            completion(image!)
        }
        catch let error
        {
            print(error)
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

