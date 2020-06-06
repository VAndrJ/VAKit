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
    
    struct VADirectionalEdgeInsets {
        static let zero: VADirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let top: CGFloat // specify amount to inset (positive) for each of the edges. values can be negative to 'outset'
        let leading: CGFloat
        let bottom: CGFloat
        let trailing: CGFloat
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
    func toSuperEdges(insets: VADirectionalEdgeInsets = .zero, multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isSafe: Bool = false, isActive: Bool = true, device: VADevice = .unspecified, configuring: ((top: NSLayoutConstraint, leading: NSLayoutConstraint, bottom: NSLayoutConstraint, trailing: NSLayoutConstraint)) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(superview != nil)
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .top, multiplier: multiplier, constant: insets.top)
        let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .leading, multiplier: multiplier, constant: insets.leading)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .bottom, multiplier: multiplier, constant: -insets.bottom)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: isSafe ? superview?.safeAreaLayoutGuide : superview, attribute: .leading, multiplier: multiplier, constant: -insets.trailing)
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
}
