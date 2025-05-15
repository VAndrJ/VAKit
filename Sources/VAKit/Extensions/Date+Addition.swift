//
//  Date+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

import Foundation

extension Date {

    func weekday(calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([.weekday], from: self).weekday
    }

    func addingMonth(_ value: Int, calendar: Calendar = .current) -> Date? {
        return calendar.date(byAdding: .month, value: value, to: self)
    }
}
