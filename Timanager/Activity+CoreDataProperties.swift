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
    
    func fill(using name: String?) {
        self.name = name
    }
}
