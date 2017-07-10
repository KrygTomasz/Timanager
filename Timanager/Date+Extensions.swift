//
//  Date+Extensions.swift
//  Timanager
//
//  Created by Kryg Tomasz on 10.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

extension Date {
    
    static func getStartDate(forDate date: Date) -> Date {
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let startDate = calendar.startOfDay(for: date)
        return startDate
        
    }
    
    static func getEndDate(forDate date: Date) -> Date {
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let startDate = calendar.startOfDay(for: date)
        guard let stopDate = calendar.date(byAdding: .day, value: 1, to: startDate) else {
            return date
        }
        return stopDate
        
    }
    
}
