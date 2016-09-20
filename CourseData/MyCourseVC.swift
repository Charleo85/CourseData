//
//  MyCourseVC.swift
//  CourseData
//
//  Created by CharlieWu on 3/12/16.
//  Copyright © 2016 CharlieWu. All rights reserved.
//

import UIKit
import CoreData

class MyCourseTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var myCourses = [MyCourse]()
    
    var fetchResultController:NSFetchedResultsController!

    
//    func load(){
//            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
//                
//                let fetchRequest = NSFetchRequest(entityName: "MyCourse")
//                do {
//                    myCourses = try managedObjectContext.executeFetchRequest(fetchRequest) as! [MyCourse]
//                } catch {
//                    print("Failed to retrieve record")
//                    print(error)
//                }
//            }
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == .Available {
            registerForPreviewingWithDelegate(self, sourceView: view)
        }
        
        // Load the course from database
        let fetchRequest = NSFetchRequest(entityName: "MyCourse")
        let sortDescriptor = NSSortDescriptor(key: "gpa", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                myCourses = fetchResultController.fetchedObjects as! [MyCourse]
            } catch {
                print("Failed to retrieve record")
                print(error)
            }
        }
        
        tableView.estimatedRowHeight = 96.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        clearsSelectionOnViewWillAppear = CourseDetailViewController!.collapsed
//        navigationController?.hidesBarsOnSwipe = true
//        load()
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
            return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return nil
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return myCourses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CourseTableViewCell
        if let course = myCourses[indexPath.row].course {
        cell.subjectLabel.text = "\(course.mnemonic!) \(course.number!)-\(course.section!) \(course.type!)"
        }
        return cell
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
            
        default:
            tableView.reloadData()
        }
        
        myCourses = controller.fetchedObjects as! [MyCourse]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            myCourses.removeAtIndex(indexPath.row)

        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action, indexPath) -> Void in
            
            let defaultText = "I am gonna take " + self.myCourses[indexPath.row].course!.mnemonic! + (self.myCourses[indexPath.row].course!.number?.description)! + " this Fall🤓" + "\n\nSent by Irïs"
            if let imageToShare = UIImage(named: "distant")/*(data: self.restaurants[indexPath.row].image!)*/ {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            }
        })
        
        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: { (action, indexPath) -> Void in
            
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            // Delete the row from the database
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                
                let myCourseToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! MyCourse
                managedObjectContext.deleteObject(myCourseToDelete)
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
            
        })
        
        // Set the button color
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
//        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMyCourse" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! CourseDetailViewController
                destinationController.course = myCourses[indexPath.row].course
            }
        }
    }

}

extension MyCourseTableViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        //        let emptydestinationViewController = CourseDetailViewController()
        
        guard let indexPath = tableView.indexPathForRowAtPoint(location),
            cell = tableView.cellForRowAtIndexPath(indexPath) else { return nil }
        
        // Create a destination view controller and set its properties.
        guard let destinationViewController = storyboard?.instantiateViewControllerWithIdentifier("main.courseDetailViewController") as? CourseDetailViewController else {return nil}
        guard let course = myCourses[indexPath.row].course
            else {return nil}
        destinationViewController.course = course
        
        /*
        Set the height of the preview by setting the preferred content size of the destination view controller. Height: 0.0 to get default height
        */
        destinationViewController.preferredContentSize = CGSize(width: 0.0, height: 0.0)
        
        previewingContext.sourceRect = cell.frame
        
        return destinationViewController
        
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing,
        commitViewController viewControllerToCommit: UIViewController){
            self.navigationController!.showViewController(viewControllerToCommit,sender:self)
    }
    
}
