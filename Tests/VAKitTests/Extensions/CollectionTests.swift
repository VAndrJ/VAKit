//
//  CollectionTests.swift
//  VAKit
//
//  Created by VAndrJ on 1/27/25.
//

import Testing
@testable import VAKit

@Suite("Collection extensions")
struct CollectionTests {

    @Test("Collection is empty")
    func emptyCollection() {
        let sut: [Int] = []

        #expect(!sut.isNotEmpty)
    }

    @Test(
        "Collection is not empty",
        arguments: [[0], [0, 1, 2], [0, 1, 2, 3, 4]]
    )
    func notEmptyCollection(value: [Int]) {
        #expect(value.isNotEmpty)
    }

    @Test(
        "Optional Collection is empty",
        arguments: [[Int](), nil]
    )
    func emptyOptionalCollection(value: [Int]?) {
        #expect(value.isEmpty)
    }

    @Test(
        "Optional Collection is not empty",
        arguments: [[0], [0, 1, 2], [0, 1, 2, 3, 4]]
    )
    func notEmptyOptionalCollection(value: [Int]?) {
        #expect(value.isNotEmpty)
    }
}
