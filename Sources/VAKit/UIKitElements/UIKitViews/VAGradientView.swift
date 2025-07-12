//
//  VAGradientView.swift
//  VAKit
//
//  Created by Volodymyr Andriienko on 12.07.2025.
//

#if canImport(UIKit)
import UIKit

open class VAGradientView: VASimpleGradientView {
    public enum AxialGradient {
        public enum Diagonal: CaseIterable {
            case topLeftToBottomRight
            case topRightToBottomLeft
            case bottomLeftToTopRight
            case bottomRightToTopLeft
        }

        case vertical
        case horizontal
        case diagonal(Diagonal)
        case custom(startPoint: CGPoint, endPoint: CGPoint)
    }

    public init(axial gradient: AxialGradient) {
        super.init()

        layer.type = .axial
        switch gradient {
        case .vertical:
            layer.startPoint = CGPoint(x: 0.5, y: 0.0)
            layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .horizontal:
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case let .diagonal(diagonal):
            switch diagonal {
            case .bottomLeftToTopRight:
                layer.startPoint = CGPoint(x: 0.0, y: 1.0)
                layer.endPoint = CGPoint(x: 1.0, y: 0.0)
            case .bottomRightToTopLeft:
                layer.startPoint = CGPoint(xy: 1.0)
                layer.endPoint = CGPoint(xy: 0.0)
            case .topLeftToBottomRight:
                layer.startPoint = CGPoint(xy: 0.0)
                layer.endPoint = CGPoint(xy: 1.0)
            case .topRightToBottomLeft:
                layer.startPoint = CGPoint(x: 1.0, y: 0.0)
                layer.endPoint = CGPoint(x: 0.0, y: 1.0)
            }
        case let .custom(startPoint, endPoint):
            layer.startPoint = startPoint
            layer.endPoint = endPoint
        }
    }

    public enum RadialGradient {
        case center
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case custom(startPoint: CGPoint, endPoint: CGPoint)
    }

    public init(radial gradient: RadialGradient) {
        super.init()

        layer.type = .radial
        switch gradient {
        case .center:
            layer.startPoint = CGPoint(xy: 0.5)
            layer.endPoint = CGPoint(xy: 1.0)
        case .topLeft:
            layer.startPoint = CGPoint(xy: 0.0)
            layer.endPoint = CGPoint(xy: 1.0)
        case .topRight:
            layer.startPoint = CGPoint(x: 1.0, y: 0.0)
            layer.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .bottomLeft:
            layer.startPoint = CGPoint(x: 0.0, y: 1.0)
            layer.endPoint = CGPoint(x: 1.0, y: 0.0)
        case .bottomRight:
            layer.startPoint = CGPoint(xy: 1.0)
            layer.endPoint = CGPoint(xy: 0.0)
        case let .custom(startPoint, endPoint):
            layer.startPoint = startPoint
            layer.endPoint = endPoint
        }
    }

    public enum ConicGradient {
        case custom(startPoint: CGPoint, endPoint: CGPoint)
    }

    public init(conic gradient: ConicGradient) {
        super.init()

        layer.type = .conic
        switch gradient {
        case let .custom(startPoint, endPoint):
            layer.startPoint = startPoint
            layer.endPoint = endPoint
        }
    }

    @discardableResult
    public func update(values: (color: UIColor, location: NSNumber)...) -> Self {
        layer.colors = values.map(\.color.cgColor)
        layer.locations = values.map(\.location)

        return self
    }

    @discardableResult
    public func update(colors: [UIColor], locations: [NSNumber]) -> Self {
        layer.colors = colors.map(\.cgColor)
        layer.locations = locations

        return self
    }

    @discardableResult
    public func update(colors: UIColor..., locations: NSNumber...) -> Self {
        layer.colors = colors.map(\.cgColor)
        layer.locations = locations

        return self
    }
}
#endif
