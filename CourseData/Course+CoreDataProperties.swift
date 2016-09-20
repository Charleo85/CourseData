//
//  Course+CoreDataProperties.swift
//  CourseData
//
//  Created by CharlieWu on 3/12/16.
//  Copyright © 2016 CharlieWu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Course {

    @NSManaged var classNumber: NSNumber?
    @NSManaged var days: String?
    @NSManaged var desc: String?
    @NSManaged var instructor: String?
    @NSManaged var mnemonic: String?
    @NSManaged var number: NSNumber?
    @NSManaged var room: String?
    @NSManaged var section: String?
    @NSManaged var title: String?
    @NSManaged var topic: String?
    @NSManaged var type: String?
    @NSManaged var url: String?

}
