//
//  PlannedActivity+CoreDataProperties.swift
//  
//
//  Created by Kryg Tomasz on 09.07.2017.
//
//

import Foundation
import CoreData


extension PlannedActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlannedActivity> {
        return NSFetchRequest<PlannedActivity>(entityName: "PlannedActivity")
    }

    @NSManaged public var stopDate: Int64
    @NSManaged public var startDate: Int64
    @NSManaged public var activity: Activity?
    
    func fill(with activity: Activity?, startDate: Int64) {
        self.activity = activity
        self.startDate = startDate
    }

}
