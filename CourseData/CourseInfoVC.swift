//
//  ViewController.swift
//  CourseData
//
//  Created by CharlieWu on 1/12/16.
//  Copyright © 2016 CharlieWu. All rights reserved.
//

import UIKit
import SafariServices
import CoreData


class CourseDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   var course : Course!
    
//    @IBOutlet var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        courseImageView.image = UIImage(named: "distant")
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
//        delay(0.2) {
                    // do stuff
        title = "\(self.course.mnemonic!) \(self.course.number!) - \(self.course.section!)"
//        }
//        self.tableView.reloadData()
        
        //instance the UITapGestureRecognizer and inform the method for the action "imageTapped"
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(CourseDetailViewController.imageTapped))
        
        //define quantity of taps
        imageTap.numberOfTapsRequired = 1
        imageTap.numberOfTouchesRequired = 1
        
        //set the image to the gesture
        courseImageView.addGestureRecognizer(imageTap)
        
//        searchDisplayController?.active = false
//        let requestURL = NSURL(string: course.url!)
//        let request = NSURLRequest(URL: requestURL!)
//        webview.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var courseImageView:UIImageView!
    @IBOutlet var tableView:UITableView!

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(CourseDetailViewController.add))
        
    }
    var toAdd : MyCourse!

    func add(){
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
//            let request = NSFetchRequest(entityName: "course")
//            let pred = NSPredicate(format: "(course.classNumber = %@)", (toAdd.course!.classNumber)!)
//            request.predicate = pred
//            
//            do {
//                let results = try managedObjectContext.executeFetchRequest(request) as! [MyCourse]
//                
//                let alertController = UIAlertController(title: "Oops...", message:
//                    "The Course is already in your list", preferredStyle: UIAlertControllerStyle.Alert)
//                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
//                
//                self.presentViewController(alertController, animated: true, completion: nil)
//                
//                } catch {
                    toAdd = NSEntityDescription.insertNewObjectForEntityForName("MyCourse", inManagedObjectContext: managedObjectContext) as! MyCourse
                    toAdd.course = course
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error)
                        let alertController = UIAlertController(title: "Failed to save", message:
                            "For some reason, please send us feedbacks", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Oops...", style: UIAlertActionStyle.Default,handler: nil))
                        return
                    }
//            }

        }
        let alertController = UIAlertController(title: "Wahoo", message:
            "It's now in your list", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Awesome", style: UIAlertActionStyle.Default,handler: nil))

//        do {
//            try stack.context.save()
//        } catch let error as NSError {
//            print("Error saving context: \(error)")
//        }
    }
    
    func imageTapped(){
        
        let svc = SFSafariViewController(URL: NSURL(string: course.url!)!, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! CourseInfoTableViewCell
//        while (self.course == nil) {
//        delay(0.1) {
        // Configure the cell...
//        let course = self.course
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Class"
            cell.valueLabel.text = "\(course.classNumber!) \(course.title!)"
        case 1:
            cell.fieldLabel.text = "Topic"
            cell.valueLabel.text = course.topic!
        case 2:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = course.type!
        case 3:
            cell.fieldLabel.text = "Instructor"
            cell.valueLabel.text = course.instructor!
        case 4:
            cell.fieldLabel.text = "Schedule"
            cell.valueLabel.text = course.days!
        case 5:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = course.room
        case 6:
            cell.fieldLabel.text = "Description"
            cell.valueLabel.text = course.desc!

        default:
        cell.fieldLabel.text = ""
        cell.valueLabel.text = ""
                }
//            }
//        }

        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    override func previewActionItems() -> [UIPreviewActionItem] {
        let regularAction = UIPreviewAction(title: "Detail", style: .Default) { (action: UIPreviewAction, vc: UIViewController) -> Void in
            
        }
        
        let destructiveAction = UIPreviewAction(title: "Add", style: .Destructive ) { (action: UIPreviewAction, vc: UIViewController) -> Void in
            
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                self.toAdd = NSEntityDescription.insertNewObjectForEntityForName("MyCourse", inManagedObjectContext: managedObjectContext) as! MyCourse
                self.toAdd.course = self.course
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                    return
                }
            }
            
        }
        
        let actionGroup = UIPreviewActionGroup(title: "Share", style: .Default, actions: [regularAction, destructiveAction])
        
        return [regularAction, destructiveAction, actionGroup]
    }
    
//    func delay(delay:Double, closure:()->()) {
//        dispatch_after(
//            dispatch_time(
//                DISPATCH_TIME_NOW,
//                Int64(delay * Double(NSEC_PER_SEC))
//            ),
//            dispatch_get_main_queue(), closure)
//    }

    
    
}


