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
    
    @discardableResult
    func size(height: CGFloat, priority: Float = 1000) -> Self {
        self.size(height: height, priority: priority, configuring: { _ in })
    }
    
    @discardableResult
    func size(height: CGFloat, priority: Float = 1000, configuring: (NSLayoutConstraint) -> Void) -> Self {
        assert(0...1000 ~= priority)
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        configuring(constraint)
        return self
    }
}
