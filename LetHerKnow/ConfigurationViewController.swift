//
//  ConfigurationViewController.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 11/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol ConfigurationViewControllerDelegate {
    func configurationViewControllerDelegateDidFinish(viewController: ConfigurationViewController)
}

class ConfigurationViewController: UIViewController, ContextAware {
    
    var mainContext: NSManagedObjectContext!
    var delegate: ConfigurationViewControllerDelegate?
    
    @IBAction func doneTapped() {
        delegate?.configurationViewControllerDelegateDidFinish(self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else {
            assertionFailure()
            return
        }
        
        switch (segue.destinationViewController, identifier) {
        case let (vc as ContactsTableViewController, "soulmateSegue"):
            vc.mainContext = mainContext
            vc.internalsFactory = SoulmateTableInternalsFactory()
        case let (vc as ContactsTableViewController, "buddiesSegue"):
            vc.mainContext = mainContext
            vc.internalsFactory = BuddiesTableInternalsFactory()
        default:
            assertionFailure()
        }
    }
}
