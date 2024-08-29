//
//  CGSize+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 8/29/24.
//

import CoreGraphics

extension CGSize {

    public init(same value: CGFloat) {
        self.init(width: value, height: value)
    }
}
