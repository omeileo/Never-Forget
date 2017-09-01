//
//  MissingChildrenMapViewController+CollectionView.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/28/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import UIKit

extension MissingChildrenMapViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return missingChildren.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let missingChildCell: MissingChildCollectionViewCell = self.missingChildrenCollectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! MissingChildCollectionViewCell
        
        //setup elements
        let child = missingChildren[indexPath.row]
        missingChildCell.avatarImage.image = child.profilePicture
        missingChildCell.missingChildName.text = "\(child.firstName) \(child.lastName[child.lastName.index(child.lastName.startIndex, offsetBy: 0)])."
        
        makeAvatarImageCircular(cell: missingChildCell)
        
        return missingChildCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //
    }
    
    func makeAvatarImageCircular(cell: MissingChildCollectionViewCell)
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
