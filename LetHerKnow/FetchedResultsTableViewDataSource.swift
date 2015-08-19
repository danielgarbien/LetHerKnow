//
//  FetchedResultsTableViewDataSource.swift
//  LetHerKnow
//
//  Created by Daniel Garbień on 14/08/15.
//  Copyright © 2015 Daniel Garbień. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol FetchedResultsCellProvider {
    func fetchedResultsTableViewDataSource(dataSource: FetchedResultsTableViewDataSource,
        cellForObject object: AnyObject,
        atIndexPath indexPath: NSIndexPath) -> UITableViewCell
}

class FetchedResultsTableViewDataSource: NSObject {
    
    let tableView: UITableView
    let fetchedResultsController: NSFetchedResultsController
    let cellProvider: FetchedResultsCellProvider
    
    init(tableView: UITableView,
        fetchedResultsController: NSFetchedResultsController,
        cellProvider: FetchedResultsCellProvider) {
            self.tableView = tableView
            self.fetchedResultsController = fetchedResultsController
            self.cellProvider = cellProvider
            super.init()
            
            self.tableView.dataSource = self
            self.fetchedResultsController.delegate = self
            try! self.fetchedResultsController.performFetch()
    }
}

// MARK: UITableViewDataSource
extension FetchedResultsTableViewDataSource: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].objects?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let object = fetchedResultsController.objectAtIndexPath(indexPath)
        return cellProvider.fetchedResultsTableViewDataSource(self,
            cellForObject: object,
            atIndexPath: indexPath)
    }
    
    // MARK: Deleting rows
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = fetchedResultsController.managedObjectContext
            let object = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
            context.performBlockAndWait {
                context.deleteObject(object)
            }
        }
    }
}

// MARK: NSFetchedResultsControllerDelegate
extension FetchedResultsTableViewDataSource: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?,
        forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
            switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            case .Move:
                tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
            case .Update:
                tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int,
        forChangeType type: NSFetchedResultsChangeType) {
            let indexSet = NSIndexSet(index: sectionIndex)
            switch type {
            case .Insert:
                tableView.insertSections(indexSet, withRowAnimation: .Automatic)
            case .Delete:
                tableView.deleteSections(indexSet, withRowAnimation: .Automatic)
            default:
                assertionFailure()
            }
    }
}
