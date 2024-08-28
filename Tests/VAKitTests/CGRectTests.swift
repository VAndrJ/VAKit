//
//  CGRectTests.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

import Testing
import CoreGraphics
@testable import VAKit

@Suite("CGRect extensions")
struct CGRectTests {

    @Suite("CGRect initializers")
    struct CGRectInitTests {

        @Test(
            "Initializer to create CGRect with specified width and height",
            arguments: [(1, 1), (9, 9), (100, 1000)]
        )
        func widthHeight(value: (width: CGFloat, height: CGFloat)) {
            let sut = CGRect(width: value.width, height: value.height)

            #expect(value.width == sut.size.width)
            #expect(value.height == sut.size.height)
            #expect(0 == sut.origin.x)
            #expect(0 == sut.origin.y)
        }
    }
}
