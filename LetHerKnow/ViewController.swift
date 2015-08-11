//
//  ViewController.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 11/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.destinationViewController {
        case let cvc as ConfigurationViewController:
            cvc.delegate = self
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
