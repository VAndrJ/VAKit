//
//  OptionalTests.swift
//  VAKit
//
//  Created by VAndrJ on 5/21/25.
//

import Testing
@testable import VAKit

@Suite
struct OptionalTests {

    @Test("Transforms optional value when present")
    func transformsValueWhenPresent() {
        let value: Int? = 5

        let result = value.mapOr({ $0 * 2 }, default: 0)

        #expect(result == 10)
    }

    @Test("Uses fallback when optional value is nil")
    func usesFallbackWhenNil() {
        let value: Int? = nil

        let result = value.mapOr({ $0 * 2 }, default: 42)

        #expect(result == 42)
    }

    @Test("Check if fallback is called only when needed")
    func fallbackIsLazy() {
        var fallbackWasCalled = false
        let value: Int? = 5

        let result = value.mapOr({ $0 * 2 }, default: {
            fallbackWasCalled = true

            return 0
        }())

        #expect(result == 10)
        #expect(!fallbackWasCalled)
    }
}
