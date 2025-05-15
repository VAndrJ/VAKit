//
//  EdgeInsets+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

#if canImport(SwiftUI)
import SwiftUI

extension EdgeInsets {
    public var vertical: CGFloat { top + bottom }
    public var horizontal: CGFloat { leading + trailing }

    public init(all value: CGFloat) {
        self.init(
            top: value,
            leading: value,
            bottom: value,
            trailing: value
        )
    }
}
#endif
