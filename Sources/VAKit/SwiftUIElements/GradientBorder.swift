//
//  GradientBorder.swift
//  VAKit
//
//  Created by VAndrJ on 5/16/25.
//

#if canImport(SwiftUI)
import SwiftUI

extension Shape {

    public func gradientBorder(
        colors: [Color],
        width: CGFloat,
        startPoint: UnitPoint = .top,
        endPoint: UnitPoint = .bottom
    ) -> some View {
        stroke(
            LinearGradient(
                gradient: .init(colors: colors),
                startPoint: startPoint,
                endPoint: endPoint
            ),
            lineWidth: width
        )
    }
}

public struct GradientBorder<S: Shape>: ViewModifier {
    let colors: [Color]
    let width: CGFloat
    let shape: S
    let startPoint: UnitPoint
    let endPoint: UnitPoint

    public init(
        colors: [Color],
        width: CGFloat,
        shape: S,
        startPoint: UnitPoint = .top,
        endPoint: UnitPoint = .bottom
    ) {
        self.colors = colors
        self.width = width
        self.shape = shape
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    public func body(content: Content) -> some View {
        content
            .clipShape(shape)
            .overlay(
                shape
                    .gradientBorder(
                        colors: colors,
                        width: width,
                        startPoint: startPoint,
                        endPoint: endPoint
                    )
            )
    }
}

extension View {

    public func gradientBorder(
        colors: [Color],
        width: CGFloat,
        shape: some Shape = Circle(),
        startPoint: UnitPoint = .top,
        endPoint: UnitPoint = .bottom
    ) -> some View {
        modifier(
            GradientBorder(
                colors: colors,
                width: width,
                shape: shape,
                startPoint: startPoint,
                endPoint: endPoint
            )
        )
    }
}
#endif
