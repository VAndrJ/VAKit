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
    func size(_ size: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isActive: Bool = true, device: VADevice = .unspecified, configuring: ((width: NSLayoutConstraint, height: NSLayoutConstraint)) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        assert(size.sign == .plus)
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size)
        widthConstraint.priority = UILayoutPriority(rawValue: priority)
        widthConstraint.identifier = device.rawValue
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size)
        heightConstraint.priority = UILayoutPriority(rawValue: priority)
        heightConstraint.identifier = device.rawValue
        if isActive {
            NSLayoutConstraint.activate([widthConstraint, heightConstraint])
        }
        configuring((widthConstraint, heightConstraint))
        return self
    }
    
    @discardableResult
    func toSuper(_ anchor: NSLayoutConstraint.Attribute) -> Self {
        return self
    }
}
