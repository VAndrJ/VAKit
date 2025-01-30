//
//  LockDequeBoxTests.swift
//  VAKit
//
//  Created by VAndrJ on 1/30/25.
//

import Testing
import Foundation
@testable import VAKit

@Suite
struct LockDequeBoxTests {

    @Test(
        "Test read and write correct result",
        arguments: [10_000, 100_000]
    )
    func readWrite(iterations: Int) async {
        let deque = LockDequeBox<Int>()
        let arr = Array(0..<iterations)
        for i in arr {
            DispatchQueue.global().async {
                deque.append(i)
                deque.prepend(i)
            }
        }
        DispatchQueue.global().async {
            deque.append(contentsOf: arr)
        }
        DispatchQueue.global().async {
            deque.prepend(contentsOf: arr)
        }
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        #expect(iterations * 4 == deque.count)
    }

    @Test("Test functions and data structure correct")
    func datAndFunctions() async {
        let deque = LockDequeBox<Int>()

        #expect(nil == deque.first)
        #expect(nil == deque.last)
        #expect(0 == deque.count)
        #expect(deque.isEmpty)

        let expectedValue = 42
        deque.append(expectedValue)

        #expect(expectedValue == deque.first)
        #expect(expectedValue == deque.last)
        #expect(1 == deque.count)
        #expect(!deque.isEmpty)

        let lastValue = deque.popLast()

        #expect(expectedValue == lastValue)
        #expect(nil == deque.first)
        #expect(nil == deque.last)
        #expect(0 == deque.count)
        #expect(deque.isEmpty)

        deque.prepend(expectedValue)

        #expect(expectedValue == deque.first)
        #expect(expectedValue == deque.last)
        #expect(1 == deque.count)
        #expect(!deque.isEmpty)

        let fristValue = deque.popFirst()

        #expect(expectedValue == fristValue)
        #expect(nil == deque.first)
        #expect(nil == deque.last)
        #expect(0 == deque.count)
        #expect(deque.isEmpty)

        #expect(nil == deque.popLast())
        #expect(nil == deque.popFirst())

        let secondExpectedValue = 24
        deque.append(expectedValue)
        deque.prepend(secondExpectedValue)

        #expect(expectedValue == deque.last)
        #expect(secondExpectedValue == deque.first)

        #expect(secondExpectedValue == deque.popFirst())

        deque.append(secondExpectedValue)

        #expect(secondExpectedValue == deque.popLast())
        #expect(1 == deque.count)
    }
}
