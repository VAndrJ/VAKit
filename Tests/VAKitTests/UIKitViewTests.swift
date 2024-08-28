//
//  UIKitViewTests.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

#if canImport(UIKit)
import Testing
import UIKit
@testable import VAKit

@Suite("UIKit views primitives")
@MainActor
struct UIKitViewTests {

    @Test func testVASimpleView() async throws {
        let frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        var sut = VASimpleView(frame: frame)
        
        #expect(frame == sut.frame)

        sut = VASimpleView()

        #expect(.zero == sut.frame)
    }

    @Test func testVAView() async throws {
        let sut = TestVaView()

        #expect(sut.isElementsAdded)
        #expect(sut.isConfigured)
        #expect(sut.isBinded)
    }
}

private class TestVaView: VAView {
    var isElementsAdded = false
    var isConfigured = false
    var isBinded = false

    override func addElements() {
        isElementsAdded = true
    }

    override func configure() {
        isConfigured = true
    }

    override func bind() {
        isBinded = true
    }
}
#endif
