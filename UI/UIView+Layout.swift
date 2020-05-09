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
    func size(height: CGFloat, priority: Float, configuring: (NSLayoutConstraint) -> Void) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        constraint.isActive = true
        return self
    }
}
