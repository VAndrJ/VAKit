//
//  UIView+Layout.swift
//  VAKit
//
//  Created by VAndrJ on 07.04.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview(_:))
    }
    
    func addAutolayoutSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
    
    func addAutolayoutSubviews(_ subviews: UIView...) {
        subviews.forEach(addAutolayoutSubview(_:))
    }
}

extension UIView {
    enum VADevice: String, CaseIterable {
        case unspecified
        case iPhonePortrait
        case iPhoneLandscape
        case iPhoneSmallLandscape
        case iPhoneLargeLandscape
        case iPad
        case iPadSplitPortrait
        
        init(identifier: String?) {
            if let identifier = identifier {
                self = VADevice(rawValue: identifier) ?? .unspecified
            } else {
                self = .unspecified
            }
        }
    }
    
    @discardableResult
    func size(height: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isActive: Bool = true, device: VADevice = .unspecified, configuring: (NSLayoutConstraint) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(height.sign == .plus)
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = isActive
        constraint.identifier = device.rawValue
        configuring(constraint)
        return self
    }
    
    @discardableResult
    func size(width: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isActive: Bool = true, device: VADevice = .unspecified, configuring: (NSLayoutConstraint) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(width.sign == .plus)
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = isActive
        constraint.identifier = device.rawValue
        configuring(constraint)
        return self
    }
    
    @discardableResult
    func size(width: CGFloat, height: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isActive: Bool = true, device: VADevice = .unspecified, configuring: ((width: NSLayoutConstraint, height: NSLayoutConstraint)) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(width.sign == .plus)
        assert(height.sign == .plus)
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        let constraints: [NSLayoutConstraint] = [widthConstraint, heightConstraint]
        constraints.forEach { (constraint: NSLayoutConstraint) in
            constraint.priority = UILayoutPriority(rawValue: priority)
            constraint.identifier = device.rawValue
        }
        if isActive {
            NSLayoutConstraint.activate(constraints)
        }
        configuring((widthConstraint, heightConstraint))
        return self
    }
    
    @discardableResult
    func size(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isActive: Bool = true, device: VADevice = .unspecified, configuring: ((width: NSLayoutConstraint, height: NSLayoutConstraint)) -> Void = { _ in }) -> Self {
        return size(width: constant, height: constant, relation: relation, priority: priority, isActive: isActive, device: device, configuring: configuring)
    }
    
    @discardableResult
    func toSuper(_ anchor: NSLayoutConstraint.Attribute, constant: CGFloat = 0, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isSafe: Bool = false, isActive: Bool = true, device: VADevice = .unspecified, configuring: (NSLayoutConstraint) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(superview != nil)
        let constraint = NSLayoutConstraint(item: self, attribute: anchor, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: anchor, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.identifier = device.rawValue
        constraint.isActive = isActive
        configuring(constraint)
        return self
    }
    
    @discardableResult
    func toSuperCenter(offset: CGPoint = .zero, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isSafe: Bool = false, isActive: Bool = true, device: VADevice = .unspecified, configuring: ((centerX: NSLayoutConstraint, centerY: NSLayoutConstraint)) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(superview != nil)
        let centerXConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .centerX, multiplier: multiplier, constant: offset.x)
        let centerYConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .centerY, multiplier: multiplier, constant: offset.y)
        let constraints: [NSLayoutConstraint] = [centerXConstraint, centerYConstraint]
        constraints.forEach { (constraint: NSLayoutConstraint) in
            constraint.priority = UILayoutPriority(rawValue: priority)
            constraint.identifier = device.rawValue
        }
        if isActive {
            NSLayoutConstraint.activate(constraints)
        }
        configuring((centerXConstraint, centerYConstraint))
        return self
    }
    
    @discardableResult
    func toSuperEdges(insets: NSDirectionalEdgeInsets = .zero, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isSafe: Bool = false, isActive: Bool = true, device: VADevice = .unspecified, configuring: ((top: NSLayoutConstraint, leading: NSLayoutConstraint, bottom: NSLayoutConstraint, trailing: NSLayoutConstraint)) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(superview != nil)
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .top, multiplier: multiplier, constant: insets.top)
        let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .leading, multiplier: multiplier, constant: insets.leading)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .bottom, multiplier: multiplier, constant: -insets.bottom)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .trailing, multiplier: multiplier, constant: -insets.trailing)
        let constraints: [NSLayoutConstraint] = [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
        constraints.forEach { (constraint: NSLayoutConstraint) in
            constraint.priority = UILayoutPriority(rawValue: priority)
            constraint.identifier = device.rawValue
        }
        if isActive {
            NSLayoutConstraint.activate(constraints)
        }
        configuring((topConstraint, leadingConstraint, bottomConstraint, trailingConstraint))
        return self
    }
    
    @discardableResult
    func toSuperAxis(_ axis: NSLayoutConstraint.Axis, symmetric: CGFloat, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isSafe: Bool = false, isActive: Bool = true, device: VADevice = .unspecified, configuring: ((leadingOrTopConstraint: NSLayoutConstraint, trailingOrBottomConstraint: NSLayoutConstraint)) -> Void = { _ in }) -> Self {
        return toSuperAxis(axis, insets: (symmetric, -symmetric), multiplier: multiplier, relation: relation, priority: priority, isSafe: isSafe, isActive: isActive, device: device, configuring: configuring)
    }
    
    @discardableResult
    func toSuperAxis(_ axis: NSLayoutConstraint.Axis, insets: (leadingOrTop: CGFloat, trailingOrBottom: CGFloat) = (0, 0), multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isSafe: Bool = false, isActive: Bool = true, device: VADevice = .unspecified, configuring: ((leadingOrTopConstraint: NSLayoutConstraint, trailingOrBottomConstraint: NSLayoutConstraint)) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(superview != nil)
        let leadingOrTopConstraint: NSLayoutConstraint
        let trailingOrBottomConstraint: NSLayoutConstraint
        switch axis {
        case .horizontal:
            leadingOrTopConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .leading, multiplier: multiplier, constant: insets.leadingOrTop)
            trailingOrBottomConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .trailing, multiplier: multiplier, constant: -insets.trailingOrBottom)
        case .vertical:
            leadingOrTopConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .top, multiplier: multiplier, constant: insets.leadingOrTop)
            trailingOrBottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .bottom, multiplier: multiplier, constant: -insets.trailingOrBottom)
        @unknown default:
            fatalError()
        }
        let constraints: [NSLayoutConstraint] = [leadingOrTopConstraint, trailingOrBottomConstraint]
        constraints.forEach { (constraint: NSLayoutConstraint) in
            constraint.priority = UILayoutPriority(rawValue: priority)
            constraint.identifier = device.rawValue
        }
        if isActive {
            NSLayoutConstraint.activate(constraints)
        }
        configuring((leadingOrTopConstraint, trailingOrBottomConstraint))
        return self
    }
    
    @discardableResult
    func toSuper(anchors: NSLayoutConstraint.Attribute..., constants: [CGFloat] = [], multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isSafe: Bool = false, isActive: Bool = true, device: VADevice = .unspecified, configuring: ([NSLayoutConstraint]) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(superview != nil)
        assert(constants.isEmpty || constants.count == anchors.count)
        let constants: [CGFloat] = constants.isEmpty ? Array(repeating: 0, count: anchors.count) : constants
        let constraints: [NSLayoutConstraint] = zip(anchors, constants).map { (attribute, constant) -> NSLayoutConstraint in
            let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: attribute, multiplier: multiplier, constant: constant)
            constraint.priority = UILayoutPriority(rawValue: priority)
            constraint.identifier = device.rawValue
            return constraint
        }
        if isActive {
            NSLayoutConstraint.activate(constraints)
        }
        configuring(constraints)
        return self
    }
    
    @discardableResult
    func anchor(_ attribute: NSLayoutConstraint.Attribute, to view: UIView, anchor otherAttribute: NSLayoutConstraint.Attribute, constant: CGFloat = 0, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isSafe: Bool = false, isActive: Bool = true, device: VADevice = .unspecified, configuring: (NSLayoutConstraint) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(superview != nil)
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relation, toItem: isSafe ? view.safeAreaLayoutGuide : view, attribute: otherAttribute, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.identifier = device.rawValue
        constraint.isActive = isActive
        configuring(constraint)
        return self
    }
    
    @discardableResult
    func anchor(_ attribute: NSLayoutConstraint.Attribute, sameTo view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isSafe: Bool = false, isActive: Bool = true, device: VADevice = .unspecified, configuring: (NSLayoutConstraint) -> Void = { _ in }) -> Self {
        return anchor(attribute, to: view, anchor: attribute, constant: constant, multiplier: multiplier, relation: relation, priority: priority, isSafe: isSafe, isActive: isActive, device: device, configuring: configuring)
    }
    
    @discardableResult
    func anchor(_ attribute: NSLayoutConstraint.Attribute, opposingTo view: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isSafe: Bool = false, isActive: Bool = true, device: VADevice = .unspecified, configuring: (NSLayoutConstraint) -> Void = { _ in }) -> Self {
        assert(![.centerX, .centerY, .centerXWithinMargins, .centerYWithinMargins, .height, .width, .notAnAttribute].contains(attribute))
        let opposingAttribute: NSLayoutConstraint.Attribute
        switch attribute {
        case .top:              opposingAttribute = .bottom
        case .bottom:           opposingAttribute = .top
        case .left:             opposingAttribute = .right
        case .right:            opposingAttribute = .left
        case .leading:          opposingAttribute = .trailing
        case .trailing:         opposingAttribute = .leading
        case .topMargin:        opposingAttribute = .bottomMargin
        case .bottomMargin:     opposingAttribute = .topMargin
        case .leftMargin:       opposingAttribute = .rightMargin
        case .rightMargin:      opposingAttribute = .leftMargin
        case .firstBaseline:    opposingAttribute = .lastBaseline
        case .lastBaseline:     opposingAttribute = .firstBaseline
        case .leadingMargin:    opposingAttribute = .trailingMargin
        case .trailingMargin:   opposingAttribute = .leadingMargin
        default: fatalError()
        }
        return anchor(attribute, to: view, anchor: opposingAttribute, constant: constant, multiplier: multiplier, relation: relation, priority: priority, isSafe: isSafe, isActive: isActive, device: device, configuring: configuring)
    }
}
