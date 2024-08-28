//
//  View+Constraints.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

#if canImport(AppKit) || canImport(UIKit)
#if canImport(AppKit)
import AppKit

public typealias PlatformView = NSView
#elseif canImport(UIKit)
import UIKit

public typealias PlatformView = UIView
#endif

@MainActor
public protocol Constraints {
    var constraints: [NSLayoutConstraint] { get }
}

extension NSLayoutConstraint: Constraints {
    public var constraints: [NSLayoutConstraint] { [self] }
}

@MainActor
public final class ConstraintsContainer: Constraints {
    public private(set) var constraints: [NSLayoutConstraint]
    public let constraintsView: PlatformView

    public init(view: PlatformView, initialConstraints: [NSLayoutConstraint] = []) {
        self.constraints = initialConstraints
        self.constraintsView = view
    }
}
#endif
