//
//  Date.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 21/05/2024.
//

import Foundation

class DateUtils{
    static func getCurrentDate() -> String {
        let todayDate = Date()
        let calender = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = Locale(identifier: "en")
        let today = dateFormatter.string(from: todayDate)
        return today
    }

    static func getToDate() -> String {
        let todayDate = Date()
        let calender = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = Locale(identifier: "en")
        let weekStart = calender.date(byAdding: .day, value: 10, to: todayDate)
        let weekAhead = dateFormatter.string(from: weekStart!)
        return weekAhead
    }
}
