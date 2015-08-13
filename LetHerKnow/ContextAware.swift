//
//  ContextAware.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 13/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData

protocol ContextAware: class {
    
    var mainContext: NSManagedObjectContext! { get set }
}
