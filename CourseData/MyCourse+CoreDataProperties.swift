//
//  MyCourse+CoreDataProperties.swift
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

extension MyCourse {

    @NSManaged var gpa: NSDecimalNumber?
    @NSManaged var course: Course?

}
