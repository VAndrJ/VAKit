//
//  LockBoxTests.swift
//  VAKit
//
//  Created by VAndrJ on 1/30/25.
//

import Testing
import Foundation
@testable import VAKit

class TestLockBoxValue: @unchecked Sendable {
    var value = 0

    func increment() {
        value += 1
    }
}

@Suite
struct LockBoxTests {

    @Test(
        "Test read and write correct result",
        arguments: [10_000, 100_000]
    )
    func readWrite(iterations: Int) async {
        let value = TestLockBoxValue()
        let lockBox = LockBox(value: TestLockBoxValue())
        for _ in 0..<iterations {
            DispatchQueue.global().async {
                value.increment()
                lockBox.update { $0.increment() }
                _ = value.value
                _ = lockBox.value.value
            }
        }
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        #expect(iterations == lockBox.value.value)
        #expect(iterations != value.value)
    }

    @Test(
        "Test dictionary mutation",
        arguments: [10_000, 100_000]
    )
    func ductionaryMutation(iterations: Int) async {
        let lockBox = LockBox(value: [String: Int]())
        let keys = (0..<iterations).map { "key\($0)" }
        for key in keys {
            DispatchQueue.global().async {
                lockBox.update { $0[key] = Int.random(in: 0...iterations) }
            }
        }
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        #expect(iterations == lockBox.value.count)
    }

    @Test(
        "Test supporting methods",
        arguments: [1_000, 10_000, 100_000]
    )
    func methods(iterations: Int) async {
        let lockBox = LockBox(value: TestLockBoxValue())

        let expectedValueForString = Int.random(in: 0...iterations)
        lockBox.modify {
            $0.value = expectedValueForString
        }
        #expect(String(expectedValueForString) == lockBox.withValue {
            "\($0.value)"
        })

        let expectedValue = Int.random(in: 0...iterations)
        #expect(expectedValue == lockBox.apply {
            $0.value = expectedValue
            return $0
        }.value)
    }
}
