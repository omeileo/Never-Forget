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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let missingChildCell: MissingChildCollectionViewCell = self.missingChildrenCollectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! MissingChildCollectionViewCell
        
        //setup elements
        
        
        return missingChildCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //
    }
}
