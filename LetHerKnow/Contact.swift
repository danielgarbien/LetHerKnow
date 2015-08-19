//
//  Contact.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 12/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData

class Contact: NSManagedObject {
    
    static let entityName = "Contact"

    convenience init(context: NSManagedObjectContext,
        identifier: String,
        displayName: String,
        soulmate: Bool,
        phoneNumber: String,
        phoneNumberIdentifier: String) {
            let entity = NSEntityDescription.entityForName(Contact.entityName, inManagedObjectContext: context)!
            self.init(entity: entity, insertIntoManagedObjectContext: context)
            
            self.identifier = identifier
            self.displayName = displayName
            self.soulmate = soulmate
            self.phoneNumber = PhoneNumber(context: context, identifier: phoneNumberIdentifier, value: phoneNumber)
    }
}

private extension PhoneNumber {
    
    static let entityName = "PhoneNumber"
    
    convenience init(context: NSManagedObjectContext,
        identifier: String,
        value: String) {
            let entity = NSEntityDescription.entityForName(PhoneNumber.entityName, inManagedObjectContext: context)!
            self.init(entity: entity, insertIntoManagedObjectContext: context)
            
            self.identifier = identifier
            self.value = value
    }
}
