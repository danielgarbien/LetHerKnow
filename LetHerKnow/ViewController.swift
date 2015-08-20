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
            rpvc.title = (sender as? UIButton)?.titleLabel?.text
            rpvc.message = messageForSegue(segue)
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
            return "I'm home, safe."
        case "barSegue":
            return "I'm at a bar, wanna join?"
        case "lateSegue":
            return "I'm going to be late."
        case "loveSegue":
            return ":*"
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
