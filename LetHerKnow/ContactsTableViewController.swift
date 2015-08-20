//
//  ContactsTableViewController.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 18/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import ContactsUI

protocol ContactsTableInternalsFactory {
    
    func fetchRequest() -> NSFetchRequest
    func contactPickerHandlerWithContext(context: NSManagedObjectContext) -> ContactPickerHandler
    func contactPickerViewControllerWithContext(context: NSManagedObjectContext) -> CNContactPickerViewController
}

class ContactsTableViewController: UITableViewController, ContextAware {
    
    private static let contactCellIdentifier = "contactCellIdentifier"
    private var fetchedResultsDataSource: FetchedResultsTableViewDataSource!
    private lazy var contactPickerDelegate: ContactPickerDelegate = {
        return ContactPickerDelegate(contactPickerHandler: self.internalsFactory.contactPickerHandlerWithContext(self.mainContext))
        }()

    var mainContext: NSManagedObjectContext!
    var internalsFactory: ContactsTableInternalsFactory!
    
    @IBAction func addTapped() {
        let contactPicker = internalsFactory.contactPickerViewControllerWithContext(mainContext)
        contactPicker.delegate = contactPickerDelegate
        presentViewController(contactPicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        // register a cell class
        tableView.registerClass(SubtitleCell.classForCoder(),
            forCellReuseIdentifier: ContactsTableViewController.contactCellIdentifier)
        
        // clear footer view
        tableView.tableFooterView = UIView()
        
        // pin a fetched results data source to the table view
        let resultsController = NSFetchedResultsController.fetchedResultsControllerWithContext(mainContext, fetchRequest: internalsFactory.fetchRequest())
        fetchedResultsDataSource = FetchedResultsTableViewDataSource(tableView: tableView,
            fetchedResultsController: resultsController,
            cellProvider: self)
    }
}

// MARK: FetchedResultsCellProvider
extension ContactsTableViewController: FetchedResultsCellProvider {
    
    func fetchedResultsTableViewDataSource(dataSource: FetchedResultsTableViewDataSource,
        cellForObject object: AnyObject, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let contact = object as! Contact
            let cell = tableView.dequeueReusableCellWithIdentifier(ContactsTableViewController.contactCellIdentifier)!
            cell.textLabel?.text = contact.displayName
            cell.detailTextLabel?.text = contact.phoneNumber.value
            
            return cell
    }
}

private extension NSFetchedResultsController {
    
    class func fetchedResultsControllerWithContext(context: NSManagedObjectContext, fetchRequest: NSFetchRequest) -> NSFetchedResultsController {
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }
}
