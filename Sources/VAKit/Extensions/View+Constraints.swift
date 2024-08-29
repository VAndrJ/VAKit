//
//  View+Constraints.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

#if canImport(AppKit) || canImport(UIKit)
@MainActor
public protocol ConstrainedItem {}

#if canImport(AppKit)
import AppKit

public typealias PlatformView = NSView
public typealias PlatformLayoutGuide = NSLayoutGuide
#else
import UIKit

public typealias PlatformView = UIView
public typealias PlatformLayoutGuide = UILayoutGuide
#endif

extension PlatformView: ConstrainedItem {

    @inline(__always) func activate(@ArrayBuilder<any Constraints> anyConstraints: () -> [any Constraints]) {
        NSLayoutConstraint.activate(anyConstraints().flatMap { $0.constraints })
    }

    public func addAutolayoutSubview(_ subview: PlatformView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
    
    @inline(__always) public func addAutolayoutSubviews(_ subviews: PlatformView...) {
        subviews.forEach { addAutolayoutSubview($0) }
    }

    @inline(__always) public func addLayoutGuides(_ guides: PlatformLayoutGuide...) {
        guides.forEach { addLayoutGuide($0) }
    }
}

extension PlatformLayoutGuide: ConstrainedItem {}

@MainActor
public protocol Constraints {
    var constraints: [NSLayoutConstraint] { get }
}

extension NSLayoutConstraint: Constraints {
    public var constraints: [NSLayoutConstraint] { [self] }
}

extension ConstrainedItem {

    @inline(__always) public func toSuper(
        _ anchor: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: Float? = nil,
        isSafe: Bool = false,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer<Self> where Self: PlatformView {
        .init(item: self).toSuper(
            anchor,
            relation: relation,
            multiplier: multiplier,
            constant: constant,
            priority: priority,
            isSafe: isSafe,
            configure: configure
        )
    }

    @inline(__always) public func toSuper(
        _ anchor: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: Float? = nil,
        isSafe: Bool = false,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer<Self> where Self: PlatformLayoutGuide {
        .init(item: self).toSuper(
            anchor,
            relation: relation,
            multiplier: multiplier,
            constant: constant,
            priority: priority,
            isSafe: isSafe,
            configure: configure
        )
    }

    @inline(__always) public func anchor(
        _ selfAnchor: NSLayoutConstraint.Attribute,
        opposedTo toItem: ConstrainedItem,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: Float? = nil,
        isSafe: Bool = false,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer<Self> {
        .init(item: self).anchor(
            selfAnchor,
            opposedTo: toItem,
            relation: relation,
            multiplier: multiplier,
            constant: constant,
            priority: priority,
            isSafe: isSafe,
            configure: configure
        )
    }

    @inline(__always) public func anchor(
        _ selfAnchor: NSLayoutConstraint.Attribute,
        sameTo toItem: ConstrainedItem,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: Float? = nil,
        isSafe: Bool = false,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer<Self> {
        .init(item: self).anchor(
            selfAnchor,
            sameTo: toItem,
            relation: relation,
            multiplier: multiplier,
            constant: constant,
            priority: priority,
            isSafe: isSafe,
            configure: configure
        )
    }

    @inline(__always) public func anchor(
        _ selfAnchor: NSLayoutConstraint.Attribute,
        to toItem: ConstrainedItem,
        anchor: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: Float? = nil,
        isSafe: Bool = false,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer<Self> {
        .init(item: self).anchor(
            selfAnchor,
            to: toItem,
            anchor: anchor,
            relation: relation,
            multiplier: multiplier,
            constant: constant,
            priority: priority,
            isSafe: isSafe,
            configure: configure
        )
    }


    @inline(__always) public func size(
        height: CGFloat,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        priority: Float? = nil,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer<Self> {
        .init(item: self).size(
            height: height,
            relation: relation,
            multiplier: multiplier,
            priority: priority,
            configure: configure
        )
    }

    public func size(
        width: CGFloat,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        priority: Float? = nil,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer<Self> {
        .init(item: self).size(
            width: width,
            relation: relation,
            multiplier: multiplier,
            priority: priority,
            configure: configure
        )
    }
}

@MainActor
public final class ConstraintsContainer<Item: ConstrainedItem>: Constraints {
    public private(set) var constraints: [NSLayoutConstraint]
    public let constrainedItem: Item

    public init(item: Item, initialConstraints: [NSLayoutConstraint] = []) {
        self.constraints = initialConstraints
        self.constrainedItem = item
    }

    public func anchor(
        _ selfAnchor: NSLayoutConstraint.Attribute,
        opposedTo toItem: ConstrainedItem,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: Float? = nil,
        isSafe: Bool = false,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer {
        return anchor(
            selfAnchor,
            to: toItem,
            anchor: selfAnchor.opposed,
            relation: relation,
            multiplier: multiplier,
            constant: constant,
            priority: priority,
            isSafe: isSafe,
            configure: configure
        )
    }

    public func anchor(
        _ selfAnchor: NSLayoutConstraint.Attribute,
        sameTo toItem: ConstrainedItem,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: Float? = nil,
        isSafe: Bool = false,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer {
        self.anchor(
            selfAnchor,
            to: toItem,
            anchor: selfAnchor,
            relation: relation,
            multiplier: multiplier,
            constant: constant,
            priority: priority,
            isSafe: isSafe,
            configure: configure
        )
    }

    public func anchor(
        _ selfAnchor: NSLayoutConstraint.Attribute,
        to toItem: ConstrainedItem,
        anchor: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: Float? = nil,
        isSafe: Bool = false,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer {
        let constraint = NSLayoutConstraint(
            item: constrainedItem,
            attribute: selfAnchor,
            relatedBy: relation,
            toItem: isSafe ? (toItem as? PlatformView)?.safeAreaLayoutGuide ?? toItem : toItem,
            attribute: anchor,
            multiplier: multiplier,
            constant: constant
        )
        if let priority {
            constraint.priority = .init(rawValue: priority)
        }
        configure(constraint)
        constraints.append(constraint)

        return self
    }

    public func size(
        height: CGFloat,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        priority: Float? = nil,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer {
        let constraint = NSLayoutConstraint(
            item: constrainedItem,
            attribute: .height,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: multiplier,
            constant: height
        )
        if let priority {
            constraint.priority = .init(rawValue: priority)
        }
        configure(constraint)
        constraints.append(constraint)

        return self
    }

    public func size(
        width: CGFloat,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        priority: Float? = nil,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer {
        let constraint = NSLayoutConstraint(
            item: constrainedItem,
            attribute: .width,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: multiplier,
            constant: width
        )
        if let priority {
            constraint.priority = .init(rawValue: priority)
        }
        configure(constraint)
        constraints.append(constraint)

        return self
    }
}

extension ConstraintsContainer where Item: PlatformView {

    public func toSuper(
        _ anchor: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: Float? = nil,
        isSafe: Bool = false,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer {
        self.anchor(
            anchor,
            sameTo: constrainedItem.superview!,
            relation: relation,
            multiplier: multiplier,
            constant: constant,
            priority: priority,
            isSafe: isSafe,
            configure: configure
        )
    }
}

extension ConstraintsContainer where Item: PlatformLayoutGuide {

    public func toSuper(
        _ anchor: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: Float? = nil,
        isSafe: Bool = false,
        configure: (NSLayoutConstraint) -> Void = { _ in }
    ) -> ConstraintsContainer {
        self.anchor(
            anchor,
            sameTo: constrainedItem.owningView!,
            relation: relation,
            multiplier: multiplier,
            constant: constant,
            priority: priority,
            isSafe: isSafe,
            configure: configure
        )
    }
}

extension NSLayoutConstraint.Attribute {
    public var opposed: NSLayoutConstraint.Attribute {
        switch self {
        case .bottom: .top
        case .top: .bottom
        case .leading: .trailing
        case .trailing: .leading
        case .left: .right
        case .right: .left
        case .firstBaseline: .lastBaseline
        case .lastBaseline: .firstBaseline
        default: fatalError("Not implemented")
        }
    }
}
#endif
