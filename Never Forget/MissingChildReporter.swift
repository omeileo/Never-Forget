//
//  MissingChildReporter.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/24/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation

enum Relationship
{
    case mother, father, aunt, uncle, guardian, sibling, grandmother, grandfather, other, none
}

struct MissingChildReporter
{
    var firstName: String?
    var lastName: String?
    var emailAddress: String?
    var relationshipWithMissingChild: Relationship?
    
    //store user's geolocation as well
    
    init(firstName: String, lastName: String, emailAddress: String, relationshipWithMissingChild: Relationship)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.relationshipWithMissingChild = relationshipWithMissingChild
    }
}