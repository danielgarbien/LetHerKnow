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
        let navigationController = window?.rootViewController as! UINavigationController
        if let contextAware = navigationController.childViewControllers.first as? ContextAware {
            contextAware.mainContext = coreDataStack.mainContext
        } else {
            assertionFailure("Root view controller must be ContextAware")
        }
        
        // Appearance
        UINavigationBar.appearance().titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor(knotColor: .Navy)]
        UINavigationBar.appearance().tintColor = UIColor(knotColor: .Navy)
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        coreDataStack.save()
    }
}
