//
//  Course+CoreDataProperties.swift
//  CourseData
//
//  Created by CharlieWu on 1/13/16.
//  Copyright © 2016 CharlieWu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Course {

    @NSManaged var mnemonic: String?
    @NSManaged var number: NSNumber?
    @NSManaged var section: String?
    @NSManaged var instructor: String?
    @NSManaged var title: String?
    @NSManaged var days: String?
    @NSManaged var type: String?
    @NSManaged var classNumber: NSNumber?
    @NSManaged var topic: String?
    @NSManaged var room: String?
    @NSManaged var desc: String?
    @NSManaged var url: String?

}
