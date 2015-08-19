//
//  SoulmateTableInternalsFactory.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 18/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData
import ContactsUI

struct SoulmateTableInternalsFactory: ContactsTableInternalsFactory {
    
    func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest.soulmateRequest()
    }
    
    func contactPickerHandlerWithContext(context: NSManagedObjectContext) -> ContactPickerHandler {
        return SoulmateContactPickerHandler(context: context)
    }
    
    func contactPickerViewControllerWithContext(context: NSManagedObjectContext) -> CNContactPickerViewController {
        let contactPicker = CNContactPickerViewController()
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        
        if let soulmate = context.fetchSoulmate() {
            // Disable soulmate contact from selection if has exactly 1 phone number
            contactPicker.predicateForEnablingContact = NSPredicate(
                format: "(phoneNumbers.@count == 1 && identifier != %@) || phoneNumbers.@count > 1",
                soulmate.identifier)
        } else {
            contactPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        }
        
        contactPicker.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
        return contactPicker
    }
}
