//
//  ViewLayoutTests.swift
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

@Suite("Platform View layout functions")
@MainActor
struct ViewLayoutTests {

    @Test("Platform View add subview AutoLayout")
    func subviewAdd() {
        let container = PlatformView()
        let sut = PlatformView()
        container.addAutolayoutSubview(sut)

        #expect(!sut.translatesAutoresizingMaskIntoConstraints)
        #expect(container.subviews == [sut])
    }
}
#endif
