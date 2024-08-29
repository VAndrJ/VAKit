//
//  UIStackView+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 8/29/24.
//

#if canImport(UIKit)
import UIKit

extension UIStackView {

    @inline(__always) public func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { addArrangedSubview($0) }
    }

    @inline(__always) public func addArrangedSubviewsArray(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }

    public func removeAllArrangedSubviewsDeactivatingConstraints() {
        let removedSubviews: [UIView] = arrangedSubviews.reduce([]) {
            removeArrangedSubview($1)

            return $0 + [$1]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap { $0.constraints })
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}
#endif
