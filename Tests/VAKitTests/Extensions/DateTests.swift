//
//  DateTests.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

import Foundation
import Testing
@testable import VAKit

@Suite
struct DateTests {
    let calendar = Calendar(identifier: .gregorian)

    @Test(
        "Day of week tests using Gregorian calendar and different dates",
        arguments: [
            (11, 0, 1),
            (11, 1, 1),
            (11, 2, 1),
            (11, 3, 1),
            (11, 4, 1),
            (11, 5, 1),
            (11, 6, 1),
            (11, 7, 1),
            (11, 0, 0),
            (11, 1, 0),
            (11, 2, 0),
            (11, 3, 0),
            (11, 4, 0),
        ]
    )
    func dayOfWeek(day: Int, addition: Int, firstWeekday: Int) throws {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = firstWeekday
        let components = DateComponents(year: 2025, month: 5, day: day + addition)

        let date = try #require(calendar.date(from: components))
        #expect((addition % 7 + calendar.firstWeekday) == date.weekday(calendar: calendar))
    }

    @Test(
        "Add different number of months",
        arguments: Array(-24...24)
    )
    func addMonth(value: Int) throws {
        var components = DateComponents(year: 2025, month: 1, day: 15)
        let date = try #require(calendar.date(from: components))
        components.month? += value
        let expected = try #require(calendar.date(from: components))
        #expect(expected == date.addingMonth(value, calendar: calendar))
    }
}
