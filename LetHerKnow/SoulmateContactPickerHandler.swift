//
//  SoulmateContactPickerHandler.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 18/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData
import ContactsUI

class SoulmateContactPickerHandler: ContactPickerHandler {
    
    private let context: NSManagedObjectContext
    
    required init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func handleContact(contact: CNContact, withPhoneNumber phoneNumber: String) {
        context.setSoulmateWithIdentifier(contact.identifier,
            displayName: contact.displayName(),
            phoneNumber: phoneNumber)
    }
}
