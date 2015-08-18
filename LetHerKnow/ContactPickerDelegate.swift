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
        if let phoneNumber = contactProperty.value as? CNPhoneNumber {
            contactPickerHandler.handleContact(contact, withPhoneNumber: phoneNumber.stringValue)
        } else {
            assertionFailure()
        }
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        if let phoneNumber = contact.firstPhoneNumber() {
            contactPickerHandler.handleContact(contact, withPhoneNumber: phoneNumber)
        } else {
            assertionFailure()
        }
    }
}
