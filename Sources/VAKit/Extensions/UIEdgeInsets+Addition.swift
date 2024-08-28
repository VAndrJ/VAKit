//
//  UIEdgeInsets+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

#if canImport(UIKit)
import UIKit

extension UIEdgeInsets {

    public init(all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
}
#endif
