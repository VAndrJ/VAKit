//
//  View+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

#if canImport(SwiftUI)
import SwiftUI

extension View {

    @inlinable public func frame(
        size: CGSize,
        alignment: Alignment = .center
    ) -> some View {
        self.frame(
            width: size.width,
            height: size.height,
            alignment: alignment
        )
    }
}
#endif
