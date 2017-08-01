//
//  MissingChildPhoto.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/1/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import CoreData

struct MissingChildPhoto
{
    var photoUrl: String?
    var photo: Data?
    var ageInPhoto: Int16?
    var description: String?
    var missingChild: MissingChild?
    var dateUploaded: Date?
    
    init(photoUrl: String, image: NSDate, ageInPhoto: Int, description: String)
    {
        self.photoUrl = photoUrl
        self.photo = photo
        self.ageInPhoto = Int16(ageInPhoto)
        self.description = description
        self.dateUploaded = Date()
    }
}

