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
        case let vc as MessageSenderViewController:
            vc.mainContext = mainContext
            vc.title = (sender as? UIButton)?.titleLabel?.text
            vc.message = messageForSegue(segue)
        default:
            assertionFailure("Unrecognized segue destination view controller")
        }
    }
    
    private func messageForSegue(segue: UIStoryboardSegue) -> String {
        guard let identifier = segue.identifier else {
            assertionFailure()
            return ""
        }
        
        switch identifier {
        case "homeSegue":
            return NSLocalizedString("I'm home, safe.", comment: "Text message")
        case "barSegue":
            return NSLocalizedString("I'm in a bar, wanna join?", comment: "Text message")
        case "lateSegue":
            return NSLocalizedString("I'm going to be late.", comment: "Text message")
        case "loveSegue":
            return NSLocalizedString(":*", comment: "Text message")
        default:
            assertionFailure()
            return ""
        }
    }
}

extension ViewController: ConfigurationViewControllerDelegate {
    
    func configurationViewControllerDelegateDidFinish(viewController: ConfigurationViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
