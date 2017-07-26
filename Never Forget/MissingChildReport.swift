//
//  MissingChildReport.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/26/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation

enum Relationship
{
    case mother, father, aunt, uncle, guardian, sibling, grandmother, grandfather, other, none
}

struct MissingChildReport
{
    var missingChild: MissingChild
    var missingChildReporter: MissingChildReporter
    var relationship: Relationship
}
