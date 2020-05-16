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
    func size(height: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isActive: Bool = true, configuring: (NSLayoutConstraint) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = isActive
        configuring(constraint)
        return self
    }
    
    @discardableResult
    func size(width: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: Float = 1000, isActive: Bool = true, configuring: (NSLayoutConstraint) -> Void = { _ in }) -> Self {
        assert(0...1000 ~= priority)
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = isActive
        configuring(constraint)
        return self
    }
}
