//
//  CALayer+AnimationInit.swift
//  VAKit
//
//  Created by VAndrJ on 6/4/25.
//

import UIKit

extension CALayer.VALayerAnimation {

    public init(
        from: (any VALayerAnimationValueConvertible)?,
        to: (any VALayerAnimationValueConvertible)?,
        keyPath: String,
        isToEqualsFrom: Bool
    ) {
        self.init(
            from: from?.animationValue,
            to: to?.animationValue,
            fromOriginalValue: from,
            toOriginalValue: to,
            keyPath: keyPath,
            isToEqualsFrom: isToEqualsFrom
        )
    }

    public static func anchorPoint(from: CGPoint, to: CGPoint) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "anchorPoint",
            isToEqualsFrom: from == to
        )
    }

    public static func backgroundColor(from: UIColor?, to: UIColor?) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "backgroundColor",
            isToEqualsFrom: from == to
        )
    }

    public static func borderColor(from: UIColor?, to: UIColor?) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "borderColor",
            isToEqualsFrom: from == to
        )
    }

    public static func borderWidth(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "borderWidth",
            isToEqualsFrom: from == to
        )
    }

    public static func cornerRadius(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "cornerRadius",
            isToEqualsFrom: from == to
        )
    }

    public static func opacity(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "opacity",
            isToEqualsFrom: from == to
        )
    }

    public static func scale(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "transform.scale",
            isToEqualsFrom: from == to
        )
    }

    public static func scaleX(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "transform.scale.x",
            isToEqualsFrom: from == to
        )
    }

    public static func scaleY(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "transform.scale.y",
            isToEqualsFrom: from == to
        )
    }

    public static func shadowColor(from: UIColor?, to: UIColor?) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "shadowColor",
            isToEqualsFrom: from == to
        )
    }

    public static func shadowOpacity(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "shadowOpacity",
            isToEqualsFrom: from == to
        )
    }

    public static func shadowOffset(from: CGSize, to: CGSize) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "shadowOffset",
            isToEqualsFrom: from == to
        )
    }

    public static func shadowRadius(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "shadowRadius",
            isToEqualsFrom: from == to
        )
    }

    public static func position(from: CGPoint, to: CGPoint) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "position",
            isToEqualsFrom: from == to
        )
    }

    public static func positionX(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "position.x",
            isToEqualsFrom: from == to
        )
    }

    public static func positionY(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "position.y",
            isToEqualsFrom: from == to
        )
    }

    public static func bounds(from: CGRect, to: CGRect) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "bounds",
            isToEqualsFrom: from == to
        )
    }

    public static func originX(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "bounds.origin.x",
            isToEqualsFrom: from == to
        )
    }

    public static func originY(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "bounds.origin.y",
            isToEqualsFrom: from == to
        )
    }

    public static func width(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "bounds.size.width",
            isToEqualsFrom: from == to
        )
    }

    public static func height(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "bounds.size.height",
            isToEqualsFrom: from == to
        )
    }

    public static func rotation(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "transform.rotation.z",
            isToEqualsFrom: from == to
        )
    }

    public static func rotationX(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "transform.rotation.x",
            isToEqualsFrom: from == to
        )
    }

    public static func rotationY(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "transform.rotation.y",
            isToEqualsFrom: from == to
        )
    }

    public static func zPosition(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "zPosition",
            isToEqualsFrom: from == to
        )
    }

    public static func rasterizationScale(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "rasterizationScale",
            isToEqualsFrom: from == to
        )
    }

    public static func shadowPath(from: UIBezierPath?, to: UIBezierPath?) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "shadowPath",
            isToEqualsFrom: from == to
        )
    }
}

extension CAGradientLayer.VALayerAnimation {

    public static func locations(from: [CGFloat]?, to: [CGFloat]?) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "locations",
            isToEqualsFrom: from == to
        )
    }

    public static func colors(from: [UIColor]?, to: [UIColor]?) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "colors",
            isToEqualsFrom: from == to
        )
    }

    public static func startPoint(from: CGPoint, to: CGPoint) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "startPoint",
            isToEqualsFrom: from == to
        )
    }

    public static func endPoint(from: CGPoint, to: CGPoint) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "endPoint",
            isToEqualsFrom: from == to
        )
    }
}

extension CAShapeLayer.VALayerAnimation {

    public static func lineDashPhase(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "lineDashPhase",
            isToEqualsFrom: from == to
        )
    }

    public static func miterLimit(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "miterLimit",
            isToEqualsFrom: from == to
        )
    }

    public static func lineWidth(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "lineWidth",
            isToEqualsFrom: from == to
        )
    }

    public static func strokeStart(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "strokeStart",
            isToEqualsFrom: from == to
        )
    }

    public static func strokeEnd(from: CGFloat, to: CGFloat) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "strokeEnd",
            isToEqualsFrom: from == to
        )
    }

    public static func strokeColor(from: UIColor?, to: UIColor?) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "strokeColor",
            isToEqualsFrom: from == to
        )
    }

    public static func fillColor(from: UIColor?, to: UIColor?) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "fillColor",
            isToEqualsFrom: from == to
        )
    }

    public static func path(from: UIBezierPath?, to: UIBezierPath?) -> Self {
        return .init(
            from: from,
            to: to,
            keyPath: "path",
            isToEqualsFrom: from == to
        )
    }
}

extension CALayer.VALayerKeyframeAnimation {

    public static func scale(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "transform.scale")
    }

    public static func positionX(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "position.x")
    }

    public static func positionY(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "position.y")
    }

    public static func opacity(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "opacity")
    }

    public static func anchorPoint(values: [CGPoint]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "anchorPoint")
    }

    public static func backgroundColor(values: [UIColor]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "backgroundColor")
    }

    public static func borderColor(values: [UIColor]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "borderColor")
    }

    public static func borderWidth(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "borderWidth")
    }

    public static func cornerRadius(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "cornerRadius")
    }

    public static func scaleX(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "transform.scale.x")
    }

    public static func scaleY(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "transform.scale.y")
    }

    public static func shadowColor(values: [UIColor]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "shadowColor")
    }

    public static func shadowOpacity(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "shadowOpacity")
    }

    public static func shadowOffset(values: [CGSize]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "shadowOffset")
    }

    public static func shadowRadius(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "shadowRadius")
    }

    public static func position(values: [CGPoint]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "position")
    }

    public static func bounds(values: [CGRect]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "bounds")
    }

    public static func originX(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "bounds.origin.x")
    }

    public static func originY(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "bounds.origin.y")
    }

    public static func width(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "bounds.size.width")
    }

    public static func height(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "bounds.size.height")
    }

    public static func rotation(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "transform.rotation.z")
    }

    public static func rotationX(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "transform.rotation.x")
    }

    public static func rotationY(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "transform.rotation.y")
    }

    public static func zPosition(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "zPosition")
    }

    public static func rasterizationScale(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "rasterizationScale")
    }

    public static func shadowPath(values: [UIBezierPath]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "shadowPath")
    }
}

extension CAGradientLayer.VALayerKeyframeAnimation {

    public static func locations(values: [[CGFloat]]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "locations")
    }

    public static func colors(values: [[UIColor]]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "colors")
    }

    public static func startPoint(values: [CGPoint]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "startPoint")
    }

    public static func endPoint(values: [CGPoint]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "endPoint")
    }
}

extension CAShapeLayer.VALayerKeyframeAnimation {

    public static func lineDashPhase(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "lineDashPhase")
    }

    public static func miterLimit(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "miterLimit")
    }

    public static func lineWidth(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "lineWidth")
    }

    public static func strokeStart(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "strokeStart")
    }

    public static func strokeEnd(values: [CGFloat]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "strokeEnd")
    }

    public static func strokeColor(values: [UIColor]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "strokeColor")
    }

    public static func fillColor(values: [UIColor]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "fillColor")
    }

    public static func path(values: [UIBezierPath]) -> Self {
        return .init(values: values.map(\.animationValue), keyPath: "path")
    }
}
