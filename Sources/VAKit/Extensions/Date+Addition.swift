//
//  Date+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

import Foundation

extension Date {

    func weekday(calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([.weekday], from: self).weekday
    }
}
