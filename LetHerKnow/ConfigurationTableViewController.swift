//
//  ConfigurationTableViewController.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 12/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ConfigurationTableViewController: UITableViewController, ContextAware {

    private static let contactCellIdentifier = "contactCellIdentifier"
    private var fetchedResultsDataSource: FetchedResultsTableViewDataSource?
    var mainContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        // register a cell class
        tableView.registerClass(UITableViewCell.classForCoder(),
            forCellReuseIdentifier: ConfigurationTableViewController.contactCellIdentifier)
        
        // pin a fetched results data source to the table view
        let resultsController = NSFetchedResultsController.soulmateFetchedResultsControllerWithContext(mainContext)
        fetchedResultsDataSource = FetchedResultsTableViewDataSource(tableView: tableView,
            fetchedResultsController: resultsController,
            cellProvider: self)
    }
}

extension ConfigurationTableViewController: FetchedResultsCellProvider {
    
    func fetchedResultsTableViewDataSource(dataSource: FetchedResultsTableViewDataSource,
        cellForObject object: AnyObject, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let contact = object as! Contact
            let cell = tableView.dequeueReusableCellWithIdentifier(ConfigurationTableViewController.contactCellIdentifier)!
            cell.textLabel?.text = contact.displayName
            cell.detailTextLabel?.text = contact.phoneNumber
            
            return cell
    }
}

private extension NSFetchedResultsController {
    
    class func soulmateFetchedResultsControllerWithContext(context: NSManagedObjectContext) -> NSFetchedResultsController {
        let request = NSFetchRequest.soulmateRequest()
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "soulmate", cacheName: nil)
        return controller
    }
}
