//
//  ViewController.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 11/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, ContextAware {
    
    var mainContext: NSManagedObjectContext!

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.destinationViewController {
        case let cvc as ConfigurationViewController:
            cvc.mainContext = mainContext
            cvc.delegate = self
        case let rpvc as ReceiverPickerViewController:
            rpvc.mainContext = mainContext
        default:
            assertionFailure("Unrecognized segue destination view controller")
        }
    }
}

extension ViewController: ConfigurationViewControllerDelegate {
    
    func configurationViewControllerDelegateDidFinish(viewController: ConfigurationViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
