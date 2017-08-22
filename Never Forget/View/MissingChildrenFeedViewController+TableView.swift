//
//  MissingChildFeedTableView.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/3/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

extension MissingChildrenFeedViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return missingChildren.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: MissingChildrenFeedTableViewCell = self.missingChildrenFeedTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MissingChildrenFeedTableViewCell
        let child = missingChildren[indexPath.row]
        
        cell.avatarImageView.image = child.profilePicture
        cell.childNameLabel.text = child.firstName + " " + missingChildren[indexPath.row].lastName
        cell.missingDateLabel.text = child.lastSeenDateString
        cell.missingAddressLabel.text = child.lastSeenAddressDistrict + ", " + child.lastSeenAddressParish.rawValue
        
        setupPhysicalAttrtibuteTags(cell: cell, child: child)
        
        makeAvatarImageCircular(cell: cell)
        
        return cell
    }
    
    func setupPhysicalAttrtibuteTags(cell: MissingChildrenFeedTableViewCell, child: MissingChild)
    {
        if let complexion = child.complexion?.rawValue, complexion != "Other"
        {
            cell.complexionLabel.text = "\(complexion) Complexion"
        }
        else
        {
            cell.complexionLabel.isHidden = true
        }
        
        if let bodyType = child.bodyType?.rawValue, bodyType != "Other"
        {
            cell.bodyTypeLabel.text = "\(bodyType)"
        }
        else
        {
            cell.bodyTypeLabel.isHidden = true
        }
        
        if let height = child.height, height != 0
        {
            cell.heightLabel.text = "\(height) cm"
        }
        else
        {
            cell.heightLabel.isHidden = true
        }
        
        guard let hairType = child.hairType?.rawValue, let hairColor = child.hairColor?.rawValue else
        {
            cell.hairDescriptionLabel.isHidden = true
            return
        }
        
        var hairTypeString = hairType
        if hairType == "Other"
        {
            hairTypeString = ""
        }
        
        var hairColorString = hairColor
        if hairColor == "Other"
        {
            hairColorString = ""
        }
        
        if hairColorString == "" && hairTypeString == ""
        {
            cell.hairDescriptionLabel.isHidden = true
        }
        else
        {
            cell.hairDescriptionLabel.text = "\(hairTypeString) \(hairColorString) Hair"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: viewMissingChildProfileSegueIdentifier, sender: missingChildren[indexPath.row])
    }
    
    func makeAvatarImageCircular(cell: MissingChildrenFeedTableViewCell)
    {
        if let image = cell.avatarImageView, let imageContainer = cell.avatarUIView
        {
            image.layer.cornerRadius = image.frame.size.width / 2.0
            image.clipsToBounds = true
            
            imageContainer.layer.cornerRadius = imageContainer.frame.size.width / 2.0
            imageContainer.clipsToBounds = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == viewMissingChildProfileSegueIdentifier
        {
            if let missingChildProfileViewController = segue.destination as? MissingChildProfileViewController, let missingChild = sender as? MissingChild
            {
                missingChildProfileViewController.missingChild = missingChild
            }
        }
    }
}
