//
//  BuddiesTableInternalsFactory.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 18/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData
import ContactsUI

struct BuddiesTableInternalsFactory: ContactsTableInternalsFactory {
    
    func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest.buddiesRequest()
    }
    
    func contactPickerHandlerWithContext(context: NSManagedObjectContext) -> ContactPickerHandler {
        return BuddyContactPickerHandler(context: context)
    }
    
    func contactPickerViewControllerWithContext(context: NSManagedObjectContext) -> CNContactPickerViewController {
        let contactPicker = CNContactPickerViewController()
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        
        let buddiesPhoneNumbersIdentifiers = context.fetchBuddies().map{ $0.phoneNumber.identifier }
        // Disable contacts with all phone numbers already added
        contactPicker.predicateForEnablingContact = NSPredicate(
            format: "NOT (ALL phoneNumbers.identifier IN %@)",
            buddiesPhoneNumbersIdentifiers)
        
        // Disable properties already added
        contactPicker.predicateForSelectionOfProperty = NSPredicate(
            format: "NOT (identifier IN %@)", buddiesPhoneNumbersIdentifiers)
        
        contactPicker.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
        
        return contactPicker
    }
    
    func cellClass() -> AnyClass {
        return BuddyCell.classForCoder()
    }
}
