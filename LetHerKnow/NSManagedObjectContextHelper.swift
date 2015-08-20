//
//  NSManagedObjectContextHelper.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 13/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func performFetchAndWait(fetchRequest: NSFetchRequest, completion: (results: [AnyObject]) -> Void) {
        performBlockAndWait() { (context) -> Void in
            do {
                let results = try self.executeFetchRequest(fetchRequest)
                completion(results: results ?? [])
            } catch {
                NSLog("Error when executing a fetch request:\n\(fetchRequest)")
            }
        }
    }
}
