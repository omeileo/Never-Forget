//
//  MissingChildReport.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/26/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation

<<<<<<< HEAD
enum Relationship
{
    case mother, father, aunt, uncle, guardian, sibling, grandmother, grandfather, other, none
=======
enum Relationship: String
{
    case mother = "Mother", father = "Father", aunt = "Aunt", uncle = "Uncle", guardian = "Guardian", sibling = "Sibling", grandmother = "Grandmother", grandfather = "Grandfather", other = "Other", none = "No Relationship"
>>>>>>> navigation-bar-experimenting
}

struct MissingChildReport
{
    var missingChild: MissingChild
    var missingChildReporter: MissingChildReporter
    var relationship: Relationship
}
