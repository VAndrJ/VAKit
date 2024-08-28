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

    @Suite("UIEdgeInsets initializer")
    struct UIEdgeInsetsInitTests {

        @Test(
            "Initializer to create UIEdgeInsets with all identical edges",
            arguments: [0, 1, 9, 100]
        )
        func all(value: CGFloat) async throws {
            let sut = UIEdgeInsets(all: value)

            #expect(value == sut.top)
            #expect(value == sut.left)
            #expect(value == sut.bottom)
            #expect(value == sut.right)
        }
    }
}
#endif
