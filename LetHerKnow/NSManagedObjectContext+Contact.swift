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
    
    func setSoulmate(identifier: String, displayName: String, phoneNumber: String) -> Contact {
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
                phoneNumber: phoneNumber,
                soulmate: true)
        }
        return contact
    }
}

extension NSFetchRequest {
    
    class func soulmateRequest() -> NSFetchRequest {
        let request = NSFetchRequest(entityName: Contact.entityName)
        request.predicate = NSPredicate(format: "soulmate == %@", NSNumber(bool: true))
        return request
    }
}
