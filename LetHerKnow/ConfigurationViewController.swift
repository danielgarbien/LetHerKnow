//
//  ConfigurationViewController.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 11/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import ContactsUI
import CoreData

protocol ConfigurationViewControllerDelegate {
    func configurationViewControllerDelegateDidFinish(viewController: ConfigurationViewController)
}

class ConfigurationViewController: UIViewController, ContextAware {
    
    var mainContext: NSManagedObjectContext!
    var delegate: ConfigurationViewControllerDelegate?
    @IBOutlet weak var soulmateLabel: UILabel!
    
    @IBAction func doneTapped() {
        delegate?.configurationViewControllerDelegateDidFinish(self)
    }

    @IBAction func addSoulmateTapped() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        contactPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        contactPicker.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
        contactPicker.delegate = self
        presentViewController(contactPicker, animated: true, completion: nil)
    }
}

extension ConfigurationViewController: CNContactPickerDelegate {
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        soulmateLabel.text = contactProperty.contact.displayName()
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        soulmateLabel.text = contact.displayName()
    }
}

private extension CNContact {
    
    func displayName() -> String {
        if nickname.isEmpty == false {
            return nickname
        }
        let nameComponents = [namePrefix, givenName, middleName, familyName, nameSuffix].filter(){ $0.isEmpty == false }
        return " ".join(nameComponents)
    }
}
