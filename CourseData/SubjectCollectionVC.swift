//
//  CollectionViewController.swift
//  CourseData
//
//  Created by Charlie Wu on 8/16/16.
//  Copyright © 2016 CharlieWu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class SubjectCollectionViewController: UICollectionViewController {
    
    var subjects = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.whiteColor()
//        collectionView?.reloadData()
//        print(subjects)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return subjects.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! subjectCollectionViewCell
//        cell.backgroundColor = UIColor.blueColor()
//        cell.subjectLabel.textColor = UIColor.whiteColor()

    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! subjectCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.layer.borderColor = UIColor.blueColor().CGColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8 // optional
        cell.subjectLabel.lineBreakMode = .ByWordWrapping
        cell.subjectLabel.numberOfLines = 4;
        cell.subjectLabel.text = subjects[indexPath.row]
        cell.contentView
        
        // Configure the cell
    
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: NSIndexPath) -> CGSize {
//        var size = CGSize(width: 180, height: 60)
//        if subjects[indexPath.row].characters.count > 10 {
//            size = CGSize(width: 180, height: 100)
//        }
//        return size
//    }

    // MARK: UICollectionViewDelegate

    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

class subjectCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subjectLabel: UILabel!
    
}


