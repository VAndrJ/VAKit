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
}
#endif
