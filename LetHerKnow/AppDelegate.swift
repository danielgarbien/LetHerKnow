//
//  AppDelegate.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 11/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import UIKit
import Contacts
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreDataStack: CoreDataStack!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        coreDataStack = CoreDataStack(momResourceName: "Model", storeFileName: "Model")
        
        // Workaround for a beta 4 bug, permission should not be required, removed after it is resolved
        // https://forums.developer.apple.com/thread/12275
        let cn = CNContactStore()
        cn.requestAccessForEntityType(CNEntityType.Contacts) { (success: Bool, error: NSError?) -> Void in }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        coreDataStack.save()
    }
}
