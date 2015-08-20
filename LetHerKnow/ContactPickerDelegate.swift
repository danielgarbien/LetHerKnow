//
//  ContactPickerDelegate.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 18/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import ContactsUI

class ContactPickerDelegate: NSObject, CNContactPickerDelegate {
    
    private let contactPickerHandler: ContactPickerHandler
    
    init(contactPickerHandler: ContactPickerHandler) {
        self.contactPickerHandler = contactPickerHandler
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        if let phoneNumber = contactProperty.value as? CNPhoneNumber, identifier = contactProperty.identifier {
            contactPickerHandler.handleContact(contact, withPhoneNumber: phoneNumber, phoneNumberIdentifier: identifier)
        } else {
            assertionFailure()
        }
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        if let phoneNumber = contact.phoneNumbers.first?.value as? CNPhoneNumber, identifier = contact.phoneNumbers.first?.identifier {
            contactPickerHandler.handleContact(contact, withPhoneNumber: phoneNumber, phoneNumberIdentifier: identifier)
        } else {
            assertionFailure()
        }
    }
}
