//
//  MessageSenderViewController.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 20/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MessageSenderViewController: UIViewController, ContextAware {
    
    var mainContext: NSManagedObjectContext!
    var message: String!
    
    
    @IBAction func soulmateTapped() {
        print(message)
    }
    
    @IBAction func buddiesTapped() {
        print(message)
    }
    
    @IBAction func elseTapped() {
        print(message)
    }
}
