//
//  EdgeInsetsTests.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

#if canImport(SwiftUI)
import Testing
import SwiftUI
@testable import VAKit

@Suite("EdgeInsets extensions")
struct EdgeInsetsTests {

    @Test("Vertical value")
    func vertical() {
        let expectedHalf: CGFloat = 1
        let sut = EdgeInsets(all: expectedHalf)

        #expect(expectedHalf * 2 == sut.vertical)
    }

    @Test("Horizontal value")
    func horizontal() {
        let expectedHalf: CGFloat = 1
        let sut = EdgeInsets(all: expectedHalf)

        #expect(expectedHalf * 2 == sut.horizontal)
    }

    @Suite("EdgeInsets initializers")
    struct EdgeInsetsInitTests {

        @Test(
            "Initializer to create EdgeInsets with all identical edges",
            arguments: [0, 1, 9, 100]
        )
        func all(value: CGFloat) {
            let sut = EdgeInsets(all: value)

            #expect(value == sut.top)
            #expect(value == sut.leading)
            #expect(value == sut.bottom)
            #expect(value == sut.trailing)
        }
    }
}
#endif
