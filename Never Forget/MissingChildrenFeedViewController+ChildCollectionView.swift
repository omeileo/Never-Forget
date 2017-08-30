//
//  MissingChildCollectionViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/8/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit

extension MissingChildrenFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // return number of children in filtered list of missing children
        return missingChildrenNeverForget.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell: MissingChildCollectionViewCell = self.neverForgetMissingChildrenCollectionView.dequeueReusableCell(withReuseIdentifier: reuserIdentifier, for: indexPath) as! MissingChildCollectionViewCell
       
        // TO-DO: Connect cell to filtered list of missing children
        let child = missingChildrenNeverForget[indexPath.row]
        let lastNameInitial = child.lastName[child.lastName.index(child.lastName.startIndex, offsetBy: 0)]
        
        // Configure the cell
        cell.avatarImage.image = child.profilePicture
        cell.missingChildName.text = "\(child.firstName) \(lastNameInitial)."
        
        makeCollectionViewAvatarImageCircular(cell: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: viewMissingChildProfileSegueIdentifier, sender: missingChildrenNeverForget[indexPath.row])
    }

    func makeCollectionViewAvatarImageCircular(cell: MissingChildCollectionViewCell)
    {
        if let image = cell.avatarImage, let imageContainer = cell.avatarUIView
        {
            image.layer.cornerRadius = image.frame.size.width / 2.0
            image.clipsToBounds = true
            
            imageContainer.layer.cornerRadius = imageContainer.frame.size.width / 2.0
            imageContainer.clipsToBounds = false
        }
    }
}
