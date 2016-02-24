//
//  SubjectTableViewController.swift
//  CourseData
//
//  Created by CharlieWu on 1/12/16.
//  Copyright © 2016 CharlieWu. All rights reserved.
//

import UIKit
import CoreData

class SubjectTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    private var courses:[Course] = []
    var fetchResultController: NSFetchedResultsController!
    
    var searchController:UISearchController!
    var searchResults:[Course] = []
    
    var coursesDict = [String: [Course]]()
    var courseSectionTitles = [String]()
    
    let courseIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    func createIndexDict() {
        for course in courses {
            // Get the first letter of the animal name and build the dictionary
            let courseKey = course.mnemonic!.substringToIndex(course.mnemonic!.startIndex.advancedBy(1))
            if var courseValues = coursesDict[courseKey] {
                courseValues.append(course)
                coursesDict[courseKey] = courseValues
            } else {
                coursesDict[courseKey] = [course]
            }
        }
        
        // Get the section titles from the dictionary's keys and sort them in ascending order
        courseSectionTitles = [String](coursesDict.keys)
        courseSectionTitles = courseSectionTitles.sort { $0 < $1 }
    }

    
//    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        searchController.active  = true;
//    }
//    
//    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
//        searchController.active  = false;
//    }
//    
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        searchController.active  = false;
//    }
//    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        searchController.active  = false;
//        
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load menu items from database
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            let fetchRequest = NSFetchRequest(entityName: "Course")
            do {
                courses = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Course]
            } catch {
                print("Failed to retrieve record")
                print(error)
            }
        }
        
        // Make the cell self size
        tableView.estimatedRowHeight = 66.0
        tableView.rowHeight = UITableViewAutomaticDimension
        createIndexDict()
        // Adding a search bar
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
//        searchController.searchBar.searchBarStyle = .Minimal
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["Department", "Instructor", "Title", "Number"]
        searchController.definesPresentationContext = true
        searchController.searchBar.delegate = self
        // Customize the appearance of the search bar
        searchController.searchBar.placeholder = "Search Courses..."
        searchController.searchBar.tintColor = UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        searchController.searchBar.barTintColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.6)
        
        if traitCollection.forceTouchCapability == .Available {
            registerForPreviewingWithDelegate(self, sourceView: view)
        }
        
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        clearsSelectionOnViewWillAppear = CourseDetailViewController!.collapsed
//        navigationController?.hidesBarsOnSwipe = true
        
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        if !searchController.active {
        return courseIndexTitles
        }else{
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        guard let index = courseSectionTitles.indexOf(title) else {
            return -1
        }
//        if (index == 0) {
//            CGRect searchBarFrame = self.searchDisplayController.searchBar.frame;
//            [tableView scrollRectToVisible:searchBarFrame animated:NO];
//            return -1;
//        }
        return index
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !searchController.active {
        return 30
        }else {
            return 0
        }
        
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if !searchController.active {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor.orangeColor()
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 15.0)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if !searchController.active {
        return courseSectionTitles.count
        }else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !searchController.active {
        return courseSectionTitles[section]
        }else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if searchController.active {
            return searchResults.count
        } else {
            let courseKey = courseSectionTitles[section]
            if let courseValues = coursesDict[courseKey] {
                return courseValues.count
            }
//            return courses.count
        }
        return courses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CourseTableViewCell
//        let detailCell = tableView.dequeueReusableCellWithIdentifier("DetailedCell", forIndexPath: indexPath) as! CourseDetailTableViewCell
        let course = (searchController.active) ? searchResults[indexPath.row] : (coursesDict[courseSectionTitles[indexPath.section]])![indexPath.row]
        //courses[indexPath.row]
//        if !searchController.active {
        cell.subjectLabel.text = "\(course.mnemonic!) \(course.number!)-\(course.section!) \(course.type!)"
            return cell
//        }else {
//           detailCell.subjectLabel.text = "\(course.mnemonic!) \(course.number!)-\(course.section!) \(course.type!)"
//           detailCell.titleLabel.text = course.title!
//            tableView.estimatedRowHeight = 166.0
//
//            return detailCell
//        }
//        let space = " "
//        let hyper = "-"

        // Configure the cell...
//        cell.nameLabel.text = menuItems[indexPath.row].name
//        cell.detailLabel.text = menuItems[indexPath.row].detail
//        cell.priceLabel.text = "$\(menuItems[indexPath.row].price as! Double)"
        
        
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
        
        courses = controller.fetchedObjects as! [Course]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    // MARK: - Search

    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
//    func filterContentForSearchText(searchText: String) {
//        searchResults = courses.filter({ (course:Course) -> Bool in
//            let instructorMatch = course.instructor!.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//            let mnemonicMatch = course.mnemonic!.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//            
//            return instructorMatch != nil || mnemonicMatch != nil
//        })
//    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCourseDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! CourseDetailViewController
//                let destinationController = (segue.destinationViewController as! UINavigationController).topViewController as! CourseDetailViewController
                destinationController.course = (searchController.active) ? searchResults[indexPath.row] : (coursesDict[courseSectionTitles[indexPath.section]])![indexPath.row]//courses[indexPath.row]
                searchController.active = false

            }
        }
    }

}

extension SubjectTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func filterContentForSearchText(searchText: String, scope: String) {
        searchResults = courses.filter({( course : Course) -> Bool in
            switch scope {
                case "Department":
                    if !searchText.containsString(" "){
                 return course.mnemonic!.lowercaseString.containsString(searchText.lowercaseString)
                    }else {
                        let parts = searchText.characters.split(" ")
                        return course.mnemonic!.lowercaseString.containsString(String(parts.first!).lowercaseString) && String(course.number!).lowercaseString.containsString(String(parts.last!).lowercaseString)
                }
                case "Number":
                 return String(course.classNumber!).lowercaseString.containsString(searchText.lowercaseString)
                case "Title":
                 return course.title!.lowercaseString.containsString(searchText.lowercaseString)
                case "Instructor":
                return course.instructor!.lowercaseString.containsString(searchText.lowercaseString)
            default:
                return false
                }
        })
        tableView.reloadData()
    }
}

extension SubjectTableViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRowAtPoint(location),
            cell = tableView.cellForRowAtIndexPath(indexPath) else { return nil }
        
        // Create a destination view controller and set its properties.
        guard let destinationViewController = storyboard?.instantiateViewControllerWithIdentifier("courseDetailViewController") as? CourseDetailViewController else { return nil }
        let course = (coursesDict[courseSectionTitles[indexPath.section]])![indexPath.row]//courses[indexPath.row]
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


