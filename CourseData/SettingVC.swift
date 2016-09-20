//
//  SettingVC.swift
//  CourseData
//
//  Created by CharlieWu on 3/5/16.
//  Copyright © 2016 CharlieWu. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    var sectionTitles = ["Leave Feedback", "Follow Us"]
    var sectionContent = [["Rate us on App Store", "Tell us your feedback"],
        ["Website", "Facebook", "Github"]]
    var links = ["https://www.wujibang.com", "https://www.facebook.com/profile.php?id=100001966972469", "https://github.com/Charleo85"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the separators of the empty rows
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.alertBody = "Check out the courses in your pocket🤓"
        notification.alertAction = "Check out more features"
        notification.soundName = UILocalNotificationDefaultSoundName
//        notification.userInfo = ["CustomField1": "w00t"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
            
            // Leave feedback section
        case 0:
            if indexPath.row == 0 {
                if let url = NSURL(string: "https://itunes.apple.com/us/app/iris/id1075956813?ls=1&mt=8") {
                    UIApplication.sharedApplication().openURL(url)
                }
            } else if indexPath.row == 1 {
//                performSegueWithIdentifier("showWebView", sender: self)
            }
            
            // Follow Us section
        case 1:
            if let url = NSURL(string: links[indexPath.row]) {
                let safariController = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
                presentViewController(safariController, animated: true, completion: nil)
            }
            
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

