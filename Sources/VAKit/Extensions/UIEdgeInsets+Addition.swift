//
//  UIEdgeInsets+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

#if canImport(UIKit)
import UIKit

extension UIEdgeInsets {
    public var vertical: CGFloat { top + bottom }
    public var horizontal: CGFloat { left + right }

    public init(all value: CGFloat) {
        self.init(
            top: value,
            left: value,
            bottom: value,
            right: value
        )
    }
}
#endif
