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
import MessageUI

class MessageSenderViewController: UIViewController, ContextAware {
    
    var mainContext: NSManagedObjectContext!
    var message: String!
    
    @IBAction func soulmateTapped() {
        guard let phoneNumber = mainContext.fetchSoulmate()?.phoneNumber.value else {
            presentViewController(UIAlertController.cancelAlertWithTitle("You have no soulmate 😔"),
                animated: true, completion: nil)
            return
        }
        composeMessage(message, recipients: [phoneNumber])
    }
    
    @IBAction func buddiesTapped() {
        let phoneNumbers = mainContext.fetchBuddies().map{ $0.phoneNumber.value }
        guard phoneNumbers.count > 0 else {
            presentViewController(UIAlertController.cancelAlertWithTitle("You have no buddies 😔"),
                animated: true, completion: nil)
            return
        }
        composeMessage(message, recipients: phoneNumbers)
    }
    
    @IBAction func elseTapped() {
        composeMessage(message, recipients: [])
    }
    
    private func composeMessage(message: String, recipients: [String]?) {
        guard MFMessageComposeViewController.canSendText() else {
            presentViewController(UIAlertController.cancelAlertWithTitle("Cannot send text 😔"),
                animated: true, completion: nil)
            return
        }
        
        let messageComposeVC = MFMessageComposeViewController(navigationBarClass: nil, toolbarClass: nil)
        messageComposeVC.body = message
        messageComposeVC.recipients = recipients
        messageComposeVC.messageComposeDelegate = self
        presentViewController(messageComposeVC, animated: true, completion: nil)
    }
}

// MARK: MFMessageComposeViewControllerDelegate
extension MessageSenderViewController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension UIAlertController {
    
    class func cancelAlertWithTitle(title: String) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        return alert
    }
}
