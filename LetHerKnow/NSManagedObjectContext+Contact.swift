//
//  NSManagedObjectContext+Contact.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 13/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func fetchSoulmate() -> Contact? {
        var soulmate: Contact?
        self.performFetchAndWait(NSFetchRequest.soulmateRequest()) { (results) -> Void in
            soulmate = results.first as? Contact
        }
        return soulmate
    }
    
    func fetchBuddies() -> [Contact] {
        var buddies = [Contact]()
        self.performFetchAndWait(NSFetchRequest.buddiesRequest()) { (results) -> Void in
            buddies = results as? [Contact] ?? []
        }
        return buddies
    }
    
    func setSoulmateWithIdentifier(identifier: String, displayName: String, phoneNumber: String, phoneNumberIdentifier: String) -> Contact {
        var contact: Contact!
        self.performBlockAndWait {
            // remove old soulmate
            if let oldSoulmate = self.fetchSoulmate() {
                self.deleteObject(oldSoulmate)
            }
            // insert new soulmate
            contact = Contact(context: self,
                identifier: identifier,
                displayName: displayName,
                soulmate: true,
                phoneNumber: phoneNumber,
                phoneNumberIdentifier: phoneNumberIdentifier)
        }
        return contact
    }
    
    func addBuddyWithIdentifier(identifier: String, displayName: String, phoneNumber: String, phoneNumberIdentifier: String) -> Contact {
        var contact: Contact!
        self.performBlockAndWait {
            contact = Contact(context: self,
                identifier: identifier,
                displayName: displayName,
                soulmate: false,
                phoneNumber: phoneNumber,
                phoneNumberIdentifier: phoneNumberIdentifier)
        }
        return contact
    }
}
