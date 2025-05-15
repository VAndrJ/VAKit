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
}
#endif
