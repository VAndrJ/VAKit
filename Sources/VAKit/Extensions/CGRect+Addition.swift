//
//  CGRect+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

import CoreGraphics

extension CGRect {
    public var top: CGFloat { origin.y }
    public var bottom: CGFloat { origin.y + height }
    public var left: CGFloat { origin.x }
    public var right: CGFloat { origin.x + width }

    public var area: CGFloat { width * height }
    public var perimeter: CGFloat { 2 * (width + height) }
    public var aspectRatio: CGFloat {
        guard height != 0 else { return 0 }

        return width / height
    }

    public init(width: CGFloat, height: CGFloat) {
        self.init(
            x: 0,
            y: 0,
            width: width,
            height: height
        )
    }

    public init(size: CGSize) {
        self.init(
            origin: .zero,
            size: size
        )
    }

    public init(center: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(
            x: center.x - width / 2,
            y: center.y - height / 2,
            width: width,
            height: height
        )
    }

    public init(center: CGPoint, size: CGSize) {
        self.init(
            x: center.x - size.width / 2,
            y: center.y - size.height / 2,
            width: size.width,
            height: size.height
        )
    }

    public init(side: CGFloat) {
        self.init(width: side, height: side)
    }
}
