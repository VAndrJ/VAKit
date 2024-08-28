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

    func anchor(
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
        ConstraintsContainer(item: self).anchor(
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
}

@MainActor
public final class ConstraintsContainer<Item: ConstrainedItem>: Constraints {
    public private(set) var constraints: [NSLayoutConstraint]
    public let constrainedItem: Item

    public init(item: Item, initialConstraints: [NSLayoutConstraint] = []) {
        self.constraints = initialConstraints
        self.constrainedItem = item
    }

    func anchor(
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
}
#endif
