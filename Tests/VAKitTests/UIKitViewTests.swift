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

        print(sut.frame)
        #expect(.zero == sut.frame)
    }
}
#endif
