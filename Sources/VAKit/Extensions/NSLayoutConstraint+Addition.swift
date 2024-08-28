//
//  NSLayoutConstraint+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

#if canImport(AppKit) || canImport(UIKit)
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

extension NSLayoutConstraint {

    public static func activate(@ArrayBuilder<NSLayoutConstraint> builder: () -> [NSLayoutConstraint]) {
        activate(builder())
    }
}
#endif
