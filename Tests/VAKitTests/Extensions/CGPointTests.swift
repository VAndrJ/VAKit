//
//  CGPointTests.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

import Testing
import CoreGraphics
@testable import VAKit

@Suite("CGPoint extensions")
struct CGPointTests {

    @Test(
        "CGPoint init with same x and y values",
        arguments: [-100, -1, 0, 1, 100]
    )
    func xyInit(value: CGFloat) async throws {
        #expect(CGPoint(x: value, y: value) == CGPoint(xy: value))
    }
}
