//
//  TableViewController.swift
//  CourseData
//
//  Created by Charlie Wu on 7/22/16.
//  Copyright © 2016 CharlieWu. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore
import pop

class ScheduleTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var myCourses = [MyCourse]()
    
    var fetchResultController:NSFetchedResultsController!

    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.registerClass(ScheduleTableViewCell.self, forCellReuseIdentifier: "scheduleCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myCourses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath) as! ScheduleTableViewCell
        if let course = myCourses[indexPath.row].course {
            cell.titleLabel.text = course.title
            cell.timeLabel.text = course.room
        }
//        cell.isLastCell = false
        cell.isCurrent = false
        return cell
    }
    
    lazy var animatedCircleView: UIView = {
        let circleView = UIView(frame: CGRectMake(0, 0, 14, 14))
        circleView.backgroundColor = UIColor.selectedGreen()
        circleView.layer.borderColor = UIColor.selectedGreen().CGColor
        circleView.layer.cornerRadius = 7
        return circleView
    }()
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let selectedIndex = indexPath.row
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ScheduleTableViewCell
        cell.isCurrent = !cell.isCurrent
//        cell.height = 65

//        if selectedIndex == self.routeViewModel.stopIndex { return }
//        
//        let animPoints = self.getAnimationTranslationPoints(tableView, selectedIndex: selectedIndex)
//        (self.animTranslationStart, self.animTranslationFinish) = animPoints
//        
//        self.animateSelection()
//        
//        let oldIndexPath = NSIndexPath(forRow: self.routeViewModel.stopIndex , inSection: 0)
//        if let oldCell = tableView.cellForRowAtIndexPath(oldIndexPath) as? StopTableViewCell {
//            self.animatedCircleView.center = self.animTranslationStart
//            self.view.addSubview(self.animatedCircleView)
//            oldCell.isCurrent = false
//            let timeStr = self.routeViewModel.timeForStop(oldIndexPath.row)
//            oldCell.animateTimeLabelTextChange(timeStr)
//        }
        
//        self.routeViewModel.stopIndex = selectedIndex
    }

    
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
    




