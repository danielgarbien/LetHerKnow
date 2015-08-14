//
//  NSFetchRequest+Contact.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 14/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData

extension NSFetchRequest {
    
    class func soulmateRequest() -> NSFetchRequest {
        let request = NSFetchRequest(entityName: Contact.entityName)
        request.predicate = NSPredicate(format: "soulmate == %@", NSNumber(bool: true))
        request.sortDescriptors = [NSSortDescriptor(key: "displayName", ascending: true)]
        return request
    }
    
    class func buddiesRequest() -> NSFetchRequest {
        let request = NSFetchRequest(entityName: Contact.entityName)
        request.predicate = NSPredicate(format: "soulmate == %@", NSNumber(bool: false))
        request.sortDescriptors = [NSSortDescriptor(key: "displayName", ascending: true)]
        return request
    }
}
