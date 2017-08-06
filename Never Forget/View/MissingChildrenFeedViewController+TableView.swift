//
//  MissingChildFeedTableView.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/3/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import Firebase

extension MissingChildrenFeedViewController: UITableViewDelegate, UITableViewDataSource
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        missingChildrenFeedTableView.delegate = self
        missingChildrenFeedTableView.dataSource = self
        
        ref = Database.database().reference()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //listen for new missing children in Firebase database
        if let missingChildrenRef = self.ref?.child("Missing Children")
        {
            missingChildrenRef.observe(.childAdded, with: {(snapshot) in
                if let missingChildDictionary = snapshot.value as? [String: AnyObject]
                {
                    var missingChild = MissingChild(gender: Gender.female, firstName: "", lastName: "", age: 0, lastSeenAt: Address(district: "", parish: Parish.notStated), lastSeenDate: "Jun 21, 2017", missingStatus: MissingStatus.missing)
                    
                    missingChild.age = missingChildDictionary["age"] as? Int16 ?? 0
                    missingChild.bodyType = BodyType(rawValue: (missingChildDictionary["bodyType"] as? String)!) ?? BodyType.other
                    missingChild.citizenship = missingChildDictionary["citizenship"] as? String ?? ""
                    missingChild.complexion = Complexion(rawValue: (missingChildDictionary["complexion"] as? String)!) ?? Complexion.other
                    missingChild.eyeColor = EyeColor(rawValue: (missingChildDictionary["eyeColor"] as? String)!) ?? EyeColor.other
                    missingChild.firstName = missingChildDictionary["firstName"] as? String ?? ""
                    missingChild.gender = Gender(rawValue: (missingChildDictionary["gender"] as? String)!) ?? Gender.female
                    missingChild.hairColor = HairColor(rawValue: (missingChildDictionary["hairColor"] as? String)!) ?? HairColor.other
                    missingChild.hairType = HairType(rawValue: (missingChildDictionary["hairType"] as? String)!) ?? HairType.other
                    missingChild.height = missingChildDictionary["height"] as? Double ?? 0.0
                    missingChild.lastName = missingChildDictionary["lastName"] as? String ?? ""
                    missingChild.lastSeenAddressDistrict = missingChildDictionary["lastSeenAddressDistrict"] as? String ?? ""
                    missingChild.lastSeenAddressParish = Parish(rawValue: (missingChildDictionary["lastSeenAddressParish"] as? String)!) ?? Parish.notStated
                    missingChild.lastSeenDateString = missingChildDictionary["lastSeenDate"] as? String ?? ""
                    missingChild.nickname = missingChildDictionary["nickname"] as? String ?? ""
                    missingChild.residingAddressDistrict = missingChildDictionary["residingAddressDistrict"] as? String ?? ""
                    missingChild.residingAddressParish = Parish(rawValue: (missingChildDictionary["residingAddressParish"] as? String)!) ?? Parish.notStated
                    missingChild.weight = missingChildDictionary["Weight"] as? Double ?? 0.0
                    
                    self.missingChildren.append(missingChild)
                    
                    DispatchQueue.main.async
                    {
                            self.missingChildrenFeedTableView.reloadData()
                    }
                    
                }
            }, withCancel: nil)
        }
        
        //missingChildrenFeedTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return missingChildren.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: MissingChildrenFeedTableViewCell = self.missingChildrenFeedTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MissingChildrenFeedTableViewCell
        let child = missingChildren[indexPath.row]
        
        // TODO: set up cell's attributes with data from Firebase
        cell.avatarImageView.image = UIImage(named: "Girl")
        cell.childNameLabel.text = child.firstName + " " + missingChildren[indexPath.row].lastName
        cell.missingDateLabel.text = child.lastSeenDateString
        cell.missingAddressLabel.text = child.lastSeenAddressDistrict + ", " + child.lastSeenAddressParish.rawValue
        cell.hairTypeLabel.text = child.hairType?.rawValue
        cell.hairColorLabel.text = child.hairColor?.rawValue
        cell.bodyTypeLabel.text = child.bodyType?.rawValue
        cell.complexionLabel.text = child.complexion?.rawValue
        cell.heightLabel.text = "\(child.height!) cm"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //segue to Missing Child Page
    }
}
