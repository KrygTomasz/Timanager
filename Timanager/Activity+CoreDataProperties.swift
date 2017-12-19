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
    @NSManaged public var isChoosen: NSNumber?
    @NSManaged public var plannedActivity: NSSet?
    
    static func clear() -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Activity>(entityName: "Activity")
        request.returnsObjectsAsFaults = false
        do {
            let activities = try context.fetch(request)
            for activity in activities {
                context.delete(activity)
            }
            try context.save()
            return true
        } catch let error as NSError {
            print("Failed to delete activities. Error : \(error) \(error.userInfo)")
        }
        return false
    }
    
    func markAsChoosen() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Activity>(entityName: "Activity")
        request.returnsObjectsAsFaults = false
        do {
            let activities = try context.fetch(request)
            for activity in activities {
                activity.isChoosen = NSNumber(value: false)
            }
            isChoosen = NSNumber(value: true)
            try context.save()
            
        } catch let error as NSError {
            print("Failed to delete activities. Error : \(error) \(error.userInfo)")
        }
    }
    
    static func getChoosen() -> Activity? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Activity>(entityName: "Activity")
        request.returnsObjectsAsFaults = false
        do {
            let activities = try context.fetch(request)
            for activity in activities {
                if activity.isChoosen == NSNumber(value: true) {
                    return activity
                }
            }
        } catch let error as NSError {
            print("Failed to delete activities. Error : \(error) \(error.userInfo)")
        }
        return nil
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
