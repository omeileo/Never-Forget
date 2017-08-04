//
//  MissingChildReport.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/26/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation

struct MissingChildReport
{
    var missingChildID: String
    var missingChildReporterID: String
    var relationship: Relationship
    var reportDate: Date
    
    init(missingChildID: String, missingChildReporterID: String, relationship: String)
    {
        self.missingChildID = missingChildID
        self.missingChildReporterID = missingChildReporterID
        self.relationship = Relationship(rawValue: relationship)!
        
        reportDate = Date()
    }
}
