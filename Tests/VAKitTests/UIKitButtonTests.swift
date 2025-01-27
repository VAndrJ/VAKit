//
//  UIKitButtonTests.swift
//  VAKit
//
//  Created by VAndrJ on 1/27/25.
//

#if canImport(UIKit)
import Testing
import UIKit
@testable import VAKit

@Suite("UIButton views primitives")
@MainActor
struct UIKitButtonTests {
    class MockTarget {
        var isTapped = false
    }

    @Test func testVASimpleButtonTap() {
        let target = MockTarget()
        let sut = VAButton()
        sut.onTap(target) {
            $0.isTapped = true
        }
        sut.callTapControlEvent()

        #expect(target.isTapped)
    }

    @Test func testVASimpleButtonTapTargetIsDeinitialized() {
        var target: MockTarget? = MockTarget()
        let sut = VAButton()
        sut.onTap(target) {
            $0.isTapped = true
        }
        target = nil
        sut.callTapControlEvent()

        #expect(nil == target)

        sut.onTap = nil

        #expect(nil == sut.actions(forTarget: sut, forControlEvent: .touchUpInside))
    }

    @Test func testVASimpleButton() {
        let frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        var sut = VASimpleButton(frame: frame)

        #expect(frame == sut.frame)

        sut = VASimpleButton()

        #expect(.zero == sut.frame)
    }
}

extension UIButton {

    func callTapControlEvent() {
        actions(forTarget: self, forControlEvent: .touchUpInside)?.forEach {
            perform(Selector($0))
        }
    }
}
#endif
