//
//  MissingChildPhoto.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/1/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct MissingChildPhoto
{
    var photoData: Data?
    var photo: UIImage?
    var ageInPhoto: Int16?
    var description: String?
    var missingChild: MissingChild?
    var dateUploaded: Date?
    
    init(photoData: Data?, photo: UIImage, ageInPhoto: Int?, description: String?)
    {
        self.photoData = photoData
        self.photo = photo
        self.description = description
        self.dateUploaded = Date()
        
        if let ageInPhoto = ageInPhoto
        {
            self.ageInPhoto = Int16(ageInPhoto)
        }
    }
}

