//
//  FilterTableVC.swift
//  CourseData
//
//  Created by Charlie Wu on 8/15/16.
//  Copyright © 2016 CharlieWu. All rights reserved.
//

import UIKit
import Alamofire
import Fuzi

class FilterTableViewController: UITableViewController {
    
    var catalogList = [String:[String]]()
    var catalog = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        sendCatalogRequest()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sendCatalogRequest() {
        /**
         Catalog
         GET http://rabi.phys.virginia.edu/mySIS/CS2/
         */
        
        // Add Headers
        let headers = [
            "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Accept-Encoding":"gzip, deflate",
            "Cache-Control":"max-age=0",
            "Referer":"http://rabi.phys.virginia.edu/",
            "User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.7 (KHTML, like Gecko) Version/9.1.2 Safari/601.7.7",
            "Accept-Language":"en-us",
            "DNT":"1",
            ]
        
        // Fetch Request
        Alamofire.request(.GET, "http://rabi.phys.virginia.edu/mySIS/CS2/", headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                if (response.result.error == nil) {
//                    debugPrint("HTTP Response Body: \(response.data)")
                    if let html = try? HTMLDocument(data: response.data!) {
                        self.parseCatalog(html)
                    }
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
    }
    
    func parseCatalog (doc:HTMLDocument) {
        if let body = doc.body {
            let roots = body.xpath(".//div[@id='accordion']/*")
            for i in 0..<roots.count {
                if i%2 == 0 {
                    if let element = roots[i]?.xpath("./a").first {
                        catalog.append(element.stringValue)
                    }
                }else{
                    if let table = roots[i]?.xpath("./table").first {
                        var list = [String]()
                        for element in table.xpath("./tr/td/a") {
                            if element.stringValue != "" {
                                list.append(element.stringValue)
                            }
                        }
                        list = list.sort { $0 < $1 }
                        catalogList[catalog.last!] = list
                    }
                }
            }
//            print(roots.count)
//            print(catalogList)
            tableView.reloadData()
        }

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catalog.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FilterCatalogCell", forIndexPath: indexPath)
        cell.textLabel!.text = catalog[indexPath.row]
//        cell.detailTextLabel?.text = "2"
        return cell
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showFilterDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! SubjectCollectionViewController
                destinationController.subjects = catalogList[catalog[indexPath.row]] ?? [""]
            }
        }
        
        
    }

}


