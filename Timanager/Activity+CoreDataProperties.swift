//
//  Activity+CoreDataProperties.swift
//  
//
//  Created by Kryg Tomasz on 09.07.2017.
//
//

import Foundation
import CoreData
import UIKit

extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var name: String?
    @NSManaged public var plannedActivity: NSSet?
    
    static func clear() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Activity>(entityName: "Activity")
        request.returnsObjectsAsFaults = false
        do {
            let activities = try context.fetch(request)
            for activity in activities {
                context.delete(activity)
            }
        } catch let error as NSError {
            print("Failed to delete activities. Error : \(error) \(error.userInfo)")
        }
    }
    
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
