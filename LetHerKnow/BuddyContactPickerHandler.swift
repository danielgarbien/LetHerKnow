//
//  BuddyContactPickerHandler.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 14/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData
import ContactsUI

class BuddyContactPickerHandler: ContactPickerHandler {

    private let context: NSManagedObjectContext
    
    required init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func handleContact(contact: CNContact, withPhoneNumber phoneNumber: CNPhoneNumber, phoneNumberIdentifier: String) {
        context.addBuddyWithIdentifier(contact.identifier,
            displayName: contact.displayName(),
            phoneNumber: phoneNumber.stringValue,
            phoneNumberIdentifier: phoneNumberIdentifier)
    }
}
