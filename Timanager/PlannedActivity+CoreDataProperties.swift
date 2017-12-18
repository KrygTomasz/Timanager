//
//  PlannedActivity+CoreDataProperties.swift
//  
//
//  Created by Kryg Tomasz on 09.07.2017.
//
//

import Foundation
import CoreData
import UIKit

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
    
    static func clear() -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<PlannedActivity>(entityName: "PlannedActivity")
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

}

