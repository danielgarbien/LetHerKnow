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
        phoneNumber: String,
        soulmate: Bool) {
            let entity = NSEntityDescription.entityForName(Contact.entityName, inManagedObjectContext: context)!
            self.init(entity: entity, insertIntoManagedObjectContext: context)
            
            self.identifier = identifier
            self.displayName = displayName
            self.phoneNumber = phoneNumber
            self.soulmate = soulmate
    }
}
