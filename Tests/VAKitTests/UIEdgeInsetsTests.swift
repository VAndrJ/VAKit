//
//  UIEdgeInsetsTests.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

#if canImport(UIKit)
import Testing
import UIKit
@testable import VAKit

@Suite("UIEdgeInsets extensions")
struct UIEdgeInsetsTests {

    @Test("Vertical value")
    func vertical() {
        let expectedHalf: CGFloat = 1
        let sut = UIEdgeInsets(all: expectedHalf)

        #expect(expectedHalf * 2 == sut.vertical)
    }

    @Test("Horizontal value")
    func horizontal() {
        let expectedHalf: CGFloat = 1
        let sut = UIEdgeInsets(all: expectedHalf)

        #expect(expectedHalf * 2 == sut.horizontal)
    }

    @Suite("UIEdgeInsets initializers")
    struct UIEdgeInsetsInitTests {

        @Test(
            "Initializer to create UIEdgeInsets with all identical edges",
            arguments: [0, 1, 9, 100]
        )
        func all(value: CGFloat) {
            let sut = UIEdgeInsets(all: value)

            #expect(value == sut.top)
            #expect(value == sut.left)
            #expect(value == sut.bottom)
            #expect(value == sut.right)
        }
    }
}
#endif
