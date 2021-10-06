//
//  DateTimeManager.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 6/24/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

public struct DateFormate {
    
    static let UTC = "yyyy-MM-dd'T'HH:mm:ss"
    static let MMM_DD_COM_yyyy = "dd-MM-YYYY"
    static let dayName = "EEEE, MMM d, yyyy"
    static let HH_MM = "hh:mm a"
    static let MMM_DD_COM_yyyy_HH_MM = "dd-MM-YYYY hh:mm a"
}

public struct TimeFormate {
    
    static let HH_mm = "HH:mm"
    static let HH_MM = "hh:mm a"
}

class DateTimeManager: NSObject {
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    //------------------------------------------------------
    
    //MARK: Shared
    
    static let shared = DateTimeManager()
    
    //------------------------------------------------------
    
    //MARK: Public
    
    func isToday(_ date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }
    
    func isYesterday(_ date: Date) -> Bool {
        return Calendar.current.isDateInYesterday(date)
    }
    
    func dateFrom(unix: Int) -> Date {
        print(unix)
        return Date(timeIntervalSince1970: TimeInterval(unix))
    }
    
    func dateFrom(unix: Int, inFormate: String) -> String {
        let date = dateFrom(unix: unix)
        dateFormatter.dateFormat = inFormate
        return dateFormatter.string(from: date)
    }
    
    func stringFrom( date: Date, inFormate: String) -> String {
        dateFormatter.dateFormat = inFormate
        
        return dateFormatter.string(from: date)
    }
    
    func stringFromGet(startTime: TimeInterval , endTime: TimeInterval , date: Date, inFormate: String) -> String {
        dateFormatter.dateFormat = inFormate
        timeFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    
    func timeFrom(unix: Int, inFormate: String) -> String {
        let date = dateFrom(unix: unix)
        dateFormatter.dateFormat = inFormate
        return dateFormatter.string(from: date)
    }
    
    func stringTimeFrom(date: Date, inFormate: String) -> String {
        dateFormatter.dateFormat = inFormate
        return dateFormatter.string(from: date)
    }
    
    func localToUTC(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "H:mm:ss"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "h:mm a"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    //------------------------------------------------------
}
