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
        switch segue.destinationViewController {
        case let ctvc as ConfigurationTableViewController:
            ctvc.mainContext = mainContext
        default:
            assertionFailure()
        }
    }
}
