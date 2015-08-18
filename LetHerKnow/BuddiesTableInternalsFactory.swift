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
    
    func contactPickerViewController() -> CNContactPickerViewController {
        let contactPicker = CNContactPickerViewController()
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        contactPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        contactPicker.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
        return contactPicker
    }
}
