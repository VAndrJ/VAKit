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

        @Test(
            "Initializer to create CGRect with specified size",
            arguments: [CGSize(width: 1, height: 1), .init(width: 9, height: 99)]
        )
        func size(value: CGSize) {
            let sut = CGRect(size: value)

            #expect(value == sut.size)
            #expect(.zero == sut.origin)
        }

        @Test(
            "Initializer to create CGRect with specified side",
            arguments: [1, 9, 100, 1000]
        )
        func side(value: CGFloat) {
            let sut = CGRect(side: value)

            #expect(value == sut.width)
            #expect(value == sut.height)
            #expect(0 == sut.origin.x)
            #expect(0 == sut.origin.y)
        }

        @Test(
            "Initializer to create CGRect with specified center and size",
            arguments: [1, 9, 100, 1000]
        )
        func centerSize(value: CGFloat) {
            let sut = CGRect(
                center: .init(x: value, y: value),
                size: .init(same: value)
            )

            #expect(value == sut.width)
            #expect(value == sut.height)
            #expect(value / 2 == sut.origin.x)
            #expect(value / 2 == sut.origin.y)
        }

        @Test(
            "Initializer to create CGRect with specified center, width and height",
            arguments: [1, 9, 100, 1000]
        )
        func centerWidthHeight(value: CGFloat) {
            let sut = CGRect(
                center: .init(x: value, y: value),
                width: value,
                height: value
            )

            #expect(value == sut.width)
            #expect(value == sut.height)
            #expect(value / 2 == sut.origin.x)
            #expect(value / 2 == sut.origin.y)
        }
    }

    @Suite("CGRect supporting variables")
    struct CGRectVariables {

        @Test(
            "CGRect sides",
            arguments: [1, 9, 100, 1000]
        )
        func sides(value: CGFloat) {
            let sut = CGRect(x: value, y: value, width: value, height: value)

            #expect(value == sut.top)
            #expect(value == sut.left)
            #expect(value + value == sut.bottom)
            #expect(value + value == sut.right)
        }

        @Test(
            "CGRect rect parameters",
            arguments: [1, 9, 100, 1000]
        )
        func parameters(value: CGFloat) {
            let sut = CGRect(x: value, y: value, width: value, height: value)

            #expect(value * value == sut.area)
            #expect(value + value + value + value == sut.perimeter)
        }

        @Test(
            "CGRect ratio",
            arguments: [0, 1, 9, 100, 1000]
        )
        func ratio(value: CGFloat) {
            let sut = CGRect(x: value, y: value, width: value * value, height: value)

            #expect(value == sut.aspectRatio)
        }

        @Test("Checking if CGRect returns correct center")
        func readsCenterCorrectly() {
            let rect = CGRect(x: 10, y: 20, width: 40, height: 60)

            let center = rect.center

            #expect(30 == center.x)
            #expect(50 == center.y)
        }

        @Test("Checking if center can be set correctly")
        func setsCenterCorrectly() {
            let center = CGPoint(xy: 150)
            var rect = CGRect(width: 100, height: 60)

            rect.center = center

            #expect(100 == rect.origin.x)
            #expect(120 == rect.origin.y)
            #expect(center == rect.center)
        }

        @Test("Checking if setting center does not change size, only origin")
        func settingCenterDoesNotChangeSize() {
            let size = CGSize(width: 100, height: 60)
            var rect = CGRect(size: size)

            rect.center = CGPoint(xy: 200)

            #expect(size == rect.size)
        }
    }
}
