//
//  Activity+CoreDataProperties.swift
//  
//
//  Created by Kryg Tomasz on 09.07.2017.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var name: String?
    @NSManaged public var plannedActivity: NSSet?
    
    func fill(using name: String?) {
        self.name = name
    }

}

// MARK: Generated accessors for plannedActivity
extension Activity {

    @objc(addPlannedActivityObject:)
    @NSManaged public func addToPlannedActivity(_ value: PlannedActivity)

    @objc(removePlannedActivityObject:)
    @NSManaged public func removeFromPlannedActivity(_ value: PlannedActivity)

    @objc(addPlannedActivity:)
    @NSManaged public func addToPlannedActivity(_ values: NSSet)

    @objc(removePlannedActivity:)
    @NSManaged public func removeFromPlannedActivity(_ values: NSSet)

}
