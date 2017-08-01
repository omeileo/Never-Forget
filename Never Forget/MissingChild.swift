//
//  MissingChild.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/24/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import EventKit

enum Gender
{
    case male, female, other
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
    case black = "Black", darkBrown = "Dark Brown", lightBrown = "Light Brown", blue = "Blue", green = "Green", grey = "Grey"
}

enum Complexion: String
{
    case darkBrown = "Dark Brown", lightBrown = "Light Brown", fair = "Fair"
}

enum BodyType: String
{
    case skinny = "Skinny", slim = "Slim", chubby = "Chubby", fat = "Fat", muscular = "Muscular"
}

enum Parish: String
{
    case kingston = "Kington", andrew = "St. Andrew", catherine = "St. Catherine", clarendon = "Clarendon", manchester = "Manchester", elizabeth = "St. Elizabeth", westmoreland = "Westmoreland", hanover = "Hanover", james = "St. James", trelawny = "Trelawny", ann = "St. Ann", mary = "St. Mary", portland = "Portland", thomas = "St. Thomas"
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
    var district: String?
    var parish: Parish?
}

struct MissingChild
{
    var gender: Gender?
    var firstName: String?
    var lastName: String?
    var nickname: String?
    var age: Int16?
    var citizenship: String?
    
    var height: Double?
    var weight: Double?
    var hairType: HairType?
    var hairColor: HairColor?
    var eyeColor: EyeColor?
    var complexion: Complexion?
    var bodyType: BodyType?
    
    var residingAddress: Address?
    var lastSeenAt: Address?
    var lastSeen: Date?
    var numberOfDaysMissing: Int?
    var missingStatus: MissingStatus?
    
    init(gender: Gender, firstName: String, lastName: String, nickname: String, age: Int, citizenship: String, height: Double, weight: Double, hairType: HairType, hairColor: HairColor, eyeColor: EyeColor, complexion: Complexion, bodyType: BodyType, residingAddress: Address, lastSeenAt: Address, lastSeen: Date, missingStatus: MissingStatus)
    {
        self.gender = gender
        self.firstName = firstName
        self.lastName = lastName
        self.nickname = nickname
        self.age = Int16(age)
        self.citizenship = citizenship
        
        self.height = height
        self.weight = weight
        self.hairType = hairType
        self.hairColor = hairColor
        self.eyeColor = eyeColor
        self.complexion = complexion
        self.bodyType = bodyType
        
        self.residingAddress = residingAddress
        self.lastSeenAt = lastSeenAt
        self.lastSeen = lastSeen
        self.missingStatus = missingStatus
        
        //calculate days between current date and lastSeen date and convert it to days
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self.lastSeen!, to: Date())
        numberOfDaysMissing = components.day!
    }
}
