//
//  ViewConstraintsTests.swift
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

@Suite("Platform View NSLayoutConstraint builder")
@MainActor
struct ViewConstraintsTests {

    @Test("NSLayoutConstraint Constraints protocol conformance")
    func constraintsProtocol() {
        let view = PlatformView()
        let sut = view.widthAnchor.constraint(equalToConstant: 100)

        #expect([sut] == sut.constraints)
    }

    @Test("Constraints container initial state")
    func containerInitial() {
        let view = PlatformView()
        let constraints = [view.widthAnchor.constraint(equalToConstant: 100)]
        let sut = ConstraintsContainer(item: view, initialConstraints: constraints)

        #expect(view == sut.constrainedItem)
        #expect(constraints == sut.constraints)
    }

    @Suite("NSLayoutConstraint container constraints")
    @MainActor
    struct ViewContainerConstraintsTests {
        
        @Test("Anchor to item constraint")
        func anchor() async throws {
            let view = PlatformView()
            let container = view.anchor(.width, to: view, anchor: .height)
            let sut = container.constraints.first!

            #expect(sut.isActive == false)
            #expect(sut.priority == .required)
            #expect(sut.multiplier == 1)
            #expect(sut.constant == 0)
            #expect(sut.firstAttribute == .width)
            #expect(sut.secondAttribute == .height)
        }
    }
}
#endif
