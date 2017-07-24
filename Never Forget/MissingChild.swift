//
//  MissingChild.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/24/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation

enum Gender
{
    case male, female, other
}

enum HairType
{
    case natural, braid, locks, processed, shortCut, bald, other
}

enum HairColor: String
{
    case black, darkBrown = "Dark Brown", lightBrown = "Light Brown", multiColored, blond, colored, other
}

enum EyeColor: String
{
    case black, darkBrown = "Dark Brown", lightBrown = "Light Brown", blue, green, grey
}

enum Complexion: String
{
    case darkBrown = "Dark Brown", lightBrown = "Light Brown", fair
}

enum BodyType: String
{
    case skinny, slim, chubby, fat, muscular
}

enum Parish: String
{
    case kingston, andrew, catherine, clarendon, manchester, elizabeth, westmoreland, hanover, james, trelawny, ann, mary, portland, thomas
}

enum County
{
    case cornwall, middlesex, surrey
}

enum MissingStatus: String
{
    case found, returnedHome, missing, deceased
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
    
    init(gender: String, firstName: String, lastName: String, nickname: String, age: Int, citizenship: String, height: Double, weight: Double, hairType: HairType, hairColor: HairColor, eyeColor: EyeColor, complexion: Complexion, bodyType: BodyType, residingAddress: Address, lastSeenAt: Address, lastSeen: Date, missingStatus: MissingStatus)
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
        let calender = Calender.current
        let components = calender.components([.day], from: self.lastSeen, to: Date())
        numberOfDaysMissing = components.day!
    }
}
