//
//  SoulmateContactPickerDelegate.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 14/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData
import ContactsUI

class SoulmateContactPickerDelegate: NSObject, CNContactPickerDelegate {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        if let phoneNumber = contactProperty.value as? CNPhoneNumber {
            context.setSoulmateWithIdentifier(contact.identifier,
                displayName: contact.displayName(),
                phoneNumber: phoneNumber.stringValue)
        } else {
            assertionFailure()
        }
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        if let phoneNumber = contact.firstPhoneNumber() {
            context.setSoulmateWithIdentifier(contact.identifier,
                displayName: contact.displayName(),
                phoneNumber: phoneNumber)
        } else {
            assertionFailure()
        }
    }
}
