//
//  CustomDataTypes.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/31/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation

enum Gender: String
{
    case male = "Boy", female = "Girl"
}

enum HairType: String
{
    case natural = "Natural", braid = "Braid", locks = "Locks", processed = "Processed", shortCut = "Short Cut", bald = "Bald", other = "Other"
}

enum HairColor: String
{
    case black = "Black", darkBrown = "Dark Brown", lightBrown = "Light Brown", multiColored = "Multi-Colored", blond = "Blond", colored = "Colored", other = "Other"
}

enum EyeColor: String
{
    case black = "Black", darkBrown = "Dark Brown", lightBrown = "Light Brown", blue = "Blue", green = "Green", grey = "Grey", other = "Other"
}

enum Complexion: String
{
    case darkBrown = "Dark Brown", lightBrown = "Light Brown", fair = "Fair", other = "Other"
}

enum BodyType: String
{
    case skinny = "Skinny", slim = "Slim", chubby = "Chubby", fat = "Fat", muscular = "Muscular", other = "Other"
}

enum Parish: String
{
    case kingston = "Kingston", andrew = "St. Andrew", catherine = "St. Catherine", clarendon = "Clarendon", manchester = "Manchester", elizabeth = "St. Elizabeth", westmoreland = "Westmoreland", hanover = "Hanover", james = "St. James", trelawny = "Trelawny", ann = "St. Ann", mary = "St. Mary", portland = "Portland", thomas = "St. Thomas", notStated
}

enum County: String
{
    case cornwall = "Cornwall", middlesex = "Middlesex", surrey = "Surrey"
}

enum MissingStatus: String
{
    case found = "Found", returnedHome = "Returned Home", missing = "Missing", deceased = "Deceased"
}

struct Address
{
    var district: String
    var parish: Parish
}

enum Relationship: String
{
    case mother = "Mother", father = "Father", aunt = "Aunt", uncle = "Uncle", guardian = "Guardian", sibling = "Sibling", grandmother = "Grandmother", grandfather = "Grandfather", other = "Other", none = "No Relationship"
}
