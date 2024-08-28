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

    @Test("Constraints activation builder")
    func constraintsActivation() {
        let view = PlatformView()
        let constraint = view.heightAnchor.constraint(equalToConstant: 100)
        let coontainer = view.anchor(.width, to: view, anchor: .height)
        view.activate {
            constraint
            coontainer
        }

        #expect(constraint.isActive)
        coontainer.constraints.forEach {
            #expect($0.isActive)
        }
    }

    @Suite("NSLayoutConstraint container constraints")
    @MainActor
    struct ViewContainerConstraintsTests {
        
        @Test("Anchor to item constraint")
        func anchor() {
            let view = PlatformView()
            let container = view.anchor(.width, to: view, anchor: .height)
            let sut = container.constraints.first!

            #expect(!sut.isActive)
            #expect(.required == sut.priority)
            #expect(1 == sut.multiplier)
            #expect(0 == sut.constant)
            #expect(.width == sut.firstAttribute)
            #expect(.height == sut.secondAttribute)
        }

        @Test("Anchor same to item's anchor constraint")
        func anchorSame() {
            let view = PlatformView()
            var sut: NSLayoutConstraint!
            let container = view.anchor(.width, sameTo: view, priority: 999, isSafe: true, configure: { sut = $0 })

            #expect(!sut.isActive)
            #expect(999 == sut.priority.rawValue)
            #expect(1 == sut.multiplier)
            #expect(0 == sut.constant)
            #expect(.width == sut.firstAttribute)
            #expect(.width == sut.secondAttribute)
            #expect(container.constraints == [sut])
        }

        @Test(
            "Anchor oposed to item's anchor constraint",
            arguments: [NSLayoutConstraint.Attribute.top, .bottom, .left, .right, .leading, .trailing, .firstBaseline, .lastBaseline]
        )
        func anchorOpposed(value: NSLayoutConstraint.Attribute) {
            let view = PlatformView()
            var sut: NSLayoutConstraint!
            let container = view.anchor(value, opposedTo: view, configure: { sut = $0 })

            #expect(!sut.isActive)
            #expect(.required == sut.priority)
            #expect(1 == sut.multiplier)
            #expect(0 == sut.constant)
            #expect(value == sut.firstAttribute)
            #expect(value.opposed == sut.secondAttribute)
            #expect(container.constraints == [sut])
        }

        @Test(
            "View to superview constraint",
            arguments: [NSLayoutConstraint.Attribute.top, .bottom, .left, .right, .leading, .trailing, .firstBaseline, .lastBaseline]
        )
        func toSuperAnchor(value: NSLayoutConstraint.Attribute) {
            let containerView = PlatformView()
            let view = PlatformView()
            containerView.addAutolayoutSubview(view)
            var sut: NSLayoutConstraint!
            let expectedConstant: CGFloat = 10
            let container = view.toSuper(value, constant: expectedConstant, configure: { sut = $0 })

            #expect(!sut.isActive)
            #expect(.required == sut.priority)
            #expect(1 == sut.multiplier)
            #expect(expectedConstant == sut.constant)
            #expect(value == sut.firstAttribute)
            #expect(container.constraints == [sut])
        }

        @Test(
            "Layout guide to superview constraint",
            arguments: [NSLayoutConstraint.Attribute.top, .bottom, .left, .right, .leading, .trailing, .firstBaseline, .lastBaseline]
        )
        func toSuperAnchorПгшву(value: NSLayoutConstraint.Attribute) {
            let containerView = PlatformView()
            let guide = PlatformLayoutGuide()
            containerView.addLayoutGuide(guide)
            var sut: NSLayoutConstraint!
            let expectedConstant: CGFloat = 10
            let container = guide.toSuper(value, constant: expectedConstant, configure: { sut = $0 })

            #expect(!sut.isActive)
            #expect(.required == sut.priority)
            #expect(1 == sut.multiplier)
            #expect(expectedConstant == sut.constant)
            #expect(value == sut.firstAttribute)
            #expect(container.constraints == [sut])
        }
    }
}
#endif
