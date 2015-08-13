//
//  CoreDataStack.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 13/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    let mainContext: NSManagedObjectContext
    private let privateContext: NSManagedObjectContext
    
    init(momResourceName: String, storeFileName: String) {
        let managedObjectModel = self.dynamicType.managedObjectModelWithName(momResourceName)
        let persistentStoreCoordinator = self.dynamicType.persistentStoreCoordinatorWithManagedObjectModel(managedObjectModel, storeFileName: storeFileName)
        
        privateContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        mainContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        mainContext.parentContext = privateContext
    }
    
    func save() {
        guard mainContext.hasChanges || privateContext.hasChanges else {
            return
        }
        
        mainContext.performBlockAndWait() {
            do {
                try self.mainContext.save()
                self.privateContext.performBlock() {
                    do {
                        try self.privateContext.save()
                    } catch {
                        NSLog("Error when saving private queue managed object context")
                    }
                }
            } catch {
                NSLog("Error when saving main queue managed object context")
            }
        }
    }
    
    private class func managedObjectModelWithName(name: String) -> NSManagedObjectModel {
        let modelURL = NSBundle.mainBundle().URLForResource(name, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }
    
    private class func persistentStoreCoordinatorWithManagedObjectModel(mom: NSManagedObjectModel, storeFileName: String) -> NSPersistentStoreCoordinator {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.addPersistentStoreToCoordinator(coordinator, storeFileName: storeFileName)
        return coordinator
    }
    
    private class func addPersistentStoreToCoordinator(coordinator: NSPersistentStoreCoordinator,
        storeFileName: String,
        configuration: String? = nil,
        options: [NSObject : AnyObject]? = nil)
        -> NSPersistentStore {
            let url =  self.storeDirectory().URLByAppendingPathComponent(storeFileName)
            return try! coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: configuration, URL: url, options: options)
    }
    
    private class func storeDirectory() -> NSURL {
        // The directory the application uses to store the Core Data store file.
        let paths = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true)
        let documentsDirectoryURL = NSURL(fileURLWithPath: paths.first!)
        let storeDirectoryURL = documentsDirectoryURL.URLByAppendingPathComponent(NSBundle.mainBundle().bundleIdentifier!)
        
        if NSFileManager.defaultManager().fileExistsAtPath(storeDirectoryURL.path!) == false {
            try! NSFileManager.defaultManager().createDirectoryAtPath(storeDirectoryURL.path!, withIntermediateDirectories: true, attributes: nil)
        }
        return storeDirectoryURL
    }
}
