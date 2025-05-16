//
//  GeometryProxy+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

#if canImport(SwiftUI)
import SwiftUI

extension GeometryProxy {
    public var center: CGPoint { .init(x: size.width / 2, y: size.height / 2) }
    public var sizeWithSafeArea: CGSize {
        .init(width: size.width + safeAreaInsets.horizontal, height: size.height + safeAreaInsets.vertical)
    }

    public enum Dimension: Sendable {
        case width
        case height
    }

    public func fraction(_ dimension: Dimension, value: CGFloat) -> CGFloat {
        let value = max(0, min(1, value))
        return switch dimension {
        case .width: size.width * value
        case .height: size.height * value
        }
    }
}
#endif
