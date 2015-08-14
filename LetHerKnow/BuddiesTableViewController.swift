//
//  BuddiesTableViewController.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 14/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import ContactsUI

class BuddiesTableViewController: UITableViewController, ContextAware {
    
    private static let contactCellIdentifier = "contactCellIdentifier"
    private var fetchedResultsDataSource: FetchedResultsTableViewDataSource?
    var mainContext: NSManagedObjectContext!
    private lazy var contactPickerDelegate: BuddiesContactPickerDelegate = {
        return BuddiesContactPickerDelegate(context: self.mainContext)
        }()
    
    @IBAction func addTapped() {
        let contactPicker = CNContactPickerViewController.buddiesContactPickerWithDelegate(contactPickerDelegate)
        presentViewController(contactPicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        // register a cell class
        tableView.registerClass(UITableViewCell.classForCoder(),
            forCellReuseIdentifier: BuddiesTableViewController.contactCellIdentifier)
        
        // pin a fetched results data source to the table view
        let resultsController = NSFetchedResultsController.soulmateFetchedResultsControllerWithContext(mainContext)
        fetchedResultsDataSource = FetchedResultsTableViewDataSource(tableView: tableView,
            fetchedResultsController: resultsController,
            cellProvider: self)
    }
}

// MARK: FetchedResultsCellProvider
extension BuddiesTableViewController: FetchedResultsCellProvider {
    
    func fetchedResultsTableViewDataSource(dataSource: FetchedResultsTableViewDataSource,
        cellForObject object: AnyObject, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let contact = object as! Contact
            let cell = tableView.dequeueReusableCellWithIdentifier(BuddiesTableViewController.contactCellIdentifier)!
            cell.textLabel?.text = contact.displayName
            cell.detailTextLabel?.text = contact.phoneNumber
            
            return cell
    }
}

private extension NSFetchedResultsController {
    
    class func soulmateFetchedResultsControllerWithContext(context: NSManagedObjectContext) -> NSFetchedResultsController {
        let request = NSFetchRequest.buddiesRequest()
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }
}

extension CNContactPickerViewController {
    
    class func buddiesContactPickerWithDelegate(delegate: CNContactPickerDelegate) -> CNContactPickerViewController {
        let contactPicker = CNContactPickerViewController()
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        contactPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        contactPicker.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
        contactPicker.delegate = delegate
        return contactPicker
    }
}
