//
//  NSLayoutConstraintTests.swift
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
import Testing
@testable import VAKit

@Suite("NSLayoutConstraint extensions")
struct NSLayoutConstraintTests {
#if canImport(AppKit)
    typealias PlatformView = NSView
#elseif canImport(UIKit)
    typealias PlatformView = UIView
#endif

    @Suite("NSLayoutConstraint builder")
    @MainActor
    struct NSLayoutConstraintBuilderTests {

        @Test("NSLayoutConstraint builder activation")
        func constraintsBuilder() {
            let view = PlatformView()
            let widthConstraint = view.widthAnchor.constraint(equalToConstant: 100)
            let heightConstraint = view.heightAnchor.constraint(equalToConstant: 100)
            NSLayoutConstraint.activate {
                widthConstraint
                heightConstraint
            }

            #expect(widthConstraint.isActive)
            #expect(heightConstraint.isActive)
        }
    }
}
#endif