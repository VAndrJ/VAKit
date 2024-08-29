//
//  CGSizeTests.swift
//  VAKit
//
//  Created by VAndrJ on 8/29/24.
//

import Testing
import CoreGraphics
@testable import VAKit

@Suite("CGSize extensions")
struct CGSizeTests {

    @Suite("CGSize initializers")
    struct CGSizeInitTests {

        @Test(
            "Initializer to create CGSize with same size",
            arguments: [1, 9, 100, 1000]
        )
        func size(value: CGFloat) {
            let sut = CGSize(same: value)

            #expect(value == sut.width)
            #expect(value == sut.height)
        }
    }
}
