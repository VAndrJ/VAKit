//
//  ViewLayoutTests.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

#if canImport(AppKit) || canImport(UIKit)
#if canImport(AppKit)
import AppKit
#else
import UIKit
#endif
import Testing
@testable import VAKit

@Suite("Platform View layout functions")
@MainActor
struct ViewLayoutTests {

    @Test("Platform View added as AutoLayout subview")
    func subviewAdd() {
        let container = PlatformView()
        let sut = PlatformView()
        container.addAutolayoutSubview(sut)

        #expect(!sut.translatesAutoresizingMaskIntoConstraints)
        #expect(container.subviews == [sut])
    }

    @Test("Multiple Platform Views added as AutoLayout subviews")
    func subviewsAdd() {
        let container = PlatformView()
        let sut = PlatformView()
        let sut1 = PlatformView()
        container.addAutolayoutSubviews(sut, sut1)

        #expect(!sut.translatesAutoresizingMaskIntoConstraints)
        #expect(!sut1.translatesAutoresizingMaskIntoConstraints)
        #expect(container.subviews == [sut, sut1])
    }

    @Test("Multiple Layout Guides added")
    func guidesAdd() {
        let container = PlatformView()
        let sut = PlatformLayoutGuide()
        let sut1 = PlatformLayoutGuide()
        container.addLayoutGuides(sut, sut1)

        #expect(sut.owningView == container)
        #expect(sut1.owningView == container)
    }
}
#endif
