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
            let container = view.anchor(
                .width,
                sameTo: view,
                priority: 999,
                isSafe: true,
                configure: { sut = $0 }
            )

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
            let container = view.anchor(
                value,
                opposedTo: view,
                configure: { sut = $0 }
            )

            #expect(!sut.isActive)
            #expect(.required == sut.priority)
            #expect(1 == sut.multiplier)
            #expect(0 == sut.constant)
            #expect(value == sut.firstAttribute)
            #expect(value.opposed == sut.secondAttribute)
            #expect(container.constraints == [sut])
        }

        @Test("Item's height constraint")
        func sizeHeight() {
            let view = PlatformView()
            var sut: NSLayoutConstraint!
            let expectedHeight: CGFloat = 100
            let priority: Float = 999
            let container = view.size(
                height: expectedHeight,
                priority: priority,
                configure: { sut = $0 }
            )

            #expect(!sut.isActive)
            #expect(priority == sut.priority.rawValue)
            #expect(1 == sut.multiplier)
            #expect(expectedHeight == sut.constant)
            #expect(.height == sut.firstAttribute)
            #expect(.notAnAttribute == sut.secondAttribute)
            #expect(container.constraints == [sut])
        }

        @Test("Item's width constraint")
        func sizeWidth() {
            let view = PlatformView()
            var sut: NSLayoutConstraint!
            let expectedWidth: CGFloat = 100
            let priority: Float = 999
            let container = view.size(
                width: expectedWidth,
                priority: priority,
                configure: { sut = $0 }
            )

            #expect(!sut.isActive)
            #expect(999 == sut.priority.rawValue)
            #expect(1 == sut.multiplier)
            #expect(expectedWidth == sut.constant)
            #expect(.width == sut.firstAttribute)
            #expect(.notAnAttribute == sut.secondAttribute)
            #expect(container.constraints == [sut])
        }

        @Test("Item's size constraints")
        func size() {
            let view = PlatformView()
            var cWidth: NSLayoutConstraint!
            var cHeight: NSLayoutConstraint!
            let expectedSize = CGSize(width: 100, height: 20)
            let container = view.size(expectedSize, configure: { cWidth = $0; cHeight = $1 })

            #expect(expectedSize.width == cWidth.constant)
            #expect(expectedSize.height == cHeight.constant)
            #expect(container.constraints == [cWidth, cHeight])
        }

        @Test("Item's size same constant constraints")
        func sizeSame() {
            let view = PlatformView()
            var cWidth: NSLayoutConstraint!
            var cHeight: NSLayoutConstraint!
            let expectedValue: CGFloat = 100
            let container = view.size(same: expectedValue, configure: { cWidth = $0; cHeight = $1 })

            #expect(expectedValue == cWidth.constant)
            #expect(expectedValue == cHeight.constant)
            #expect(container.constraints == [cWidth, cHeight])
        }

        @Test("Item's aspect ratio width to height constraints")
        func aspectWidth() {
            let view = PlatformView()
            var sut: NSLayoutConstraint!
            let expectedValue: CGFloat = 100
            let expectedMultiplier: CGFloat = 2
            let priority: Float = 999
            let container = view.aspectWidth(
                heightMultiplier: expectedMultiplier,
                constant: expectedValue,
                priority: priority,
                configure: { sut = $0 }
            )

            #expect(expectedValue == sut.constant)
            #expect(priority == sut.priority.rawValue)
            #expect(expectedMultiplier == sut.multiplier)
            #expect(.width == sut.firstAttribute)
            #expect(.height == sut.secondAttribute)
            #expect(container.constraints == [sut])
        }

        @Test("Item's aspect ratio height to width constraints")
        func aspectHeight() {
            let view = PlatformView()
            var sut: NSLayoutConstraint!
            let expectedValue: CGFloat = 100
            let expectedMultiplier: CGFloat = 2
            let priority: Float = 999
            let container = view.aspectHeight(
                widthMultiplier: expectedMultiplier,
                constant: expectedValue,
                priority: priority,
                configure: { sut = $0 }
            )

            #expect(expectedValue == sut.constant)
            #expect(priority == sut.priority.rawValue)
            #expect(expectedMultiplier == sut.multiplier)
            #expect(.height == sut.firstAttribute)
            #expect(.width == sut.secondAttribute)
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
            let container = view.toSuper(
                value,
                constant: expectedConstant,
                configure: { sut = $0 }
            )

            #expect(!sut.isActive)
            #expect(.required == sut.priority)
            #expect(1 == sut.multiplier)
            #expect(expectedConstant == sut.constant)
            #expect(value == sut.firstAttribute)
            #expect(container.constraints == [sut])
        }

        @Test("View to superview center constraints")
        func toSuperCenter() {
            let containerView = PlatformView()
            let view = PlatformView()
            containerView.addAutolayoutSubview(view)
            var cCenterX: NSLayoutConstraint!
            var cCenterY: NSLayoutConstraint!
            let offset = CGSize(width: 100, height: 20)
            let container = view.toSuperCenter(
                offset: offset,
                configure: {
                    cCenterX = $0
                    cCenterY = $1
                }
            )

            #expect(offset.width == cCenterX.constant)
            #expect(.centerX == cCenterX.firstAttribute)
            #expect(.centerX == cCenterX.secondAttribute)
            #expect(offset.height == cCenterY.constant)
            #expect(.centerY == cCenterY.firstAttribute)
            #expect(.centerY == cCenterY.secondAttribute)
            #expect(container.constraints == [cCenterX, cCenterY])
        }

        @Test("View to superview anchors")
        func toSuperAnchors() {
            let containerView = PlatformView()
            let view = PlatformView()
            containerView.addAutolayoutSubview(view)
            let sut = view.toSuper(anchors: .leading, .bottom, .trailing)

            #expect(3 == sut.constraints.count)
            #expect(.leading == sut.constraints[0].firstAttribute)
            #expect(.leading == sut.constraints[0].secondAttribute)
            #expect(.bottom == sut.constraints[1].firstAttribute)
            #expect(.bottom == sut.constraints[1].secondAttribute)
            #expect(.trailing == sut.constraints[2].firstAttribute)
            #expect(.trailing == sut.constraints[2].secondAttribute)
        }

        @Test("View Container to superview anchors")
        func toSuperAnchorsContainer() {
            let containerView = PlatformView()
            let view = PlatformView()
            let container = ConstraintsContainer(item: view)
            containerView.addAutolayoutSubview(view)
            let sut = container.toSuper(anchors: .leading, .bottom, .trailing)

            #expect(3 == sut.constraints.count)
            #expect(.leading == sut.constraints[0].firstAttribute)
            #expect(.leading == sut.constraints[0].secondAttribute)
            #expect(.bottom == sut.constraints[1].firstAttribute)
            #expect(.bottom == sut.constraints[1].secondAttribute)
            #expect(.trailing == sut.constraints[2].firstAttribute)
            #expect(.trailing == sut.constraints[2].secondAttribute)
        }

        @Test("View to superview horizontal axis constraints")
        func toSuperAxisHorizontal() {
            let containerView = PlatformView()
            let view = PlatformView()
            containerView.addAutolayoutSubview(view)
            var cLeading: NSLayoutConstraint!
            var cTrailing: NSLayoutConstraint!
            let expectedValue: CGFloat = 42
            let container = view.toSuperAxis(
                .horizontal,
                topOrLeadingConstant: expectedValue,
                bottomOrTrailingConstant: expectedValue,
                configure: { cLeading = $0; cTrailing = $1 }
            )

            #expect(expectedValue == cLeading.constant)
            #expect(.leading == cLeading.firstAttribute)
            #expect(.leading == cLeading.secondAttribute)
            #expect(expectedValue == cTrailing.constant)
            #expect(.trailing == cTrailing.firstAttribute)
            #expect(.trailing == cTrailing.secondAttribute)
            #expect(container.constraints == [cLeading, cTrailing])
        }

        @Test("View to superview vertical axis constraints")
        func toSuperAxisVertical() {
            let containerView = PlatformView()
            let view = PlatformView()
            containerView.addAutolayoutSubview(view)
            var cTop: NSLayoutConstraint!
            var cBottom: NSLayoutConstraint!
            let expectedValue: CGFloat = 42
            let container = view.toSuperAxis(
                .vertical,
                topOrLeadingConstant: expectedValue,
                bottomOrTrailingConstant: expectedValue,
                configure: { cTop = $0; cBottom = $1 }
            )

            #expect(expectedValue == cTop.constant)
            #expect(.top == cTop.firstAttribute)
            #expect(.top == cTop.secondAttribute)
            #expect(expectedValue == cBottom.constant)
            #expect(.bottom == cBottom.firstAttribute)
            #expect(.bottom == cBottom.secondAttribute)
            #expect(container.constraints == [cTop, cBottom])
        }

        @Test("View to superview vertical axis padding constraints")
        func toSuperAxisVerticalPadding() {
            let containerView = PlatformView()
            let view = PlatformView()
            containerView.addAutolayoutSubview(view)
            var cTop: NSLayoutConstraint!
            var cBottom: NSLayoutConstraint!
            let expectedValue: CGFloat = 42
            let container = view.toSuperAxis(
                .vertical,
                padding: expectedValue,
                configure: { cTop = $0; cBottom = $1 }
            )

            #expect(expectedValue == cTop.constant)
            #expect(.top == cTop.firstAttribute)
            #expect(.top == cTop.secondAttribute)
            #expect(-expectedValue == cBottom.constant)
            #expect(.bottom == cBottom.firstAttribute)
            #expect(.bottom == cBottom.secondAttribute)
            #expect(container.constraints == [cTop, cBottom])
        }

        @Test("View to superview edges constraints")
        func toSuperEdges() {
            let containerView = PlatformView()
            let view = PlatformView()
            containerView.addAutolayoutSubview(view)
            var cTop: NSLayoutConstraint!
            var cLeading: NSLayoutConstraint!
            var cBottom: NSLayoutConstraint!
            var cTrailing: NSLayoutConstraint!
            let insets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
            let container = view.toSuperEdges(
                insets: insets,
                configure: {
                    cTop = $0
                    cLeading = $1
                    cBottom = $2
                    cTrailing = $3
                }
            )

            #expect(insets.top == cTop.constant)
            #expect(.top == cTop.firstAttribute)
            #expect(.top == cTop.secondAttribute)
            #expect(insets.leading == cLeading.constant)
            #expect(.leading == cLeading.firstAttribute)
            #expect(.leading == cLeading.secondAttribute)
            #expect(insets.bottom == cBottom.constant)
            #expect(.bottom == cBottom.firstAttribute)
            #expect(.bottom == cBottom.secondAttribute)
            #expect(insets.trailing == cTrailing.constant)
            #expect(.trailing == cTrailing.firstAttribute)
            #expect(.trailing == cTrailing.secondAttribute)
            #expect(container.constraints == [cTop, cLeading, cBottom, cTrailing])
        }

        @Test("View to superview edges")
        func toSuperEdgesContainer() {
            let containerView = PlatformView()
            let view = PlatformView()
            containerView.addAutolayoutSubview(view)
            let insets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
            let container = view.toSuperEdges(insets: insets)

            #expect(4 == container.constraints.count)
            #expect(insets.top == container.constraints[0].constant)
            #expect(.top == container.constraints[0].firstAttribute)
            #expect(.top == container.constraints[0].secondAttribute)
            #expect(insets.leading == container.constraints[1].constant)
            #expect(.leading == container.constraints[1].firstAttribute)
            #expect(.leading == container.constraints[1].secondAttribute)
            #expect(insets.bottom == container.constraints[2].constant)
            #expect(.bottom == container.constraints[2].firstAttribute)
            #expect(.bottom == container.constraints[2].secondAttribute)
            #expect(insets.trailing == container.constraints[3].constant)
            #expect(.trailing == container.constraints[3].firstAttribute)
            #expect(.trailing == container.constraints[3].secondAttribute)
        }

        @Test(
            "Layout guide to superview constraint",
            arguments: [NSLayoutConstraint.Attribute.top, .bottom, .left, .right, .leading, .trailing, .firstBaseline, .lastBaseline]
        )
        func toSuperAnchorGuide(value: NSLayoutConstraint.Attribute) {
            let containerView = PlatformView()
            let guide = PlatformLayoutGuide()
            containerView.addLayoutGuide(guide)
            var sut: NSLayoutConstraint!
            let expectedConstant: CGFloat = 10
            let container = guide.toSuper(
                value,
                constant: expectedConstant,
                configure: { sut = $0 }
            )

            #expect(!sut.isActive)
            #expect(.required == sut.priority)
            #expect(1 == sut.multiplier)
            #expect(expectedConstant == sut.constant)
            #expect(value == sut.firstAttribute)
            #expect(container.constraints == [sut])
        }

        // TODO: - indirect for other functions.
        @Test(
            "Layout guide to superview constraint indirect",
            arguments: [NSLayoutConstraint.Attribute.top, .bottom, .left, .right, .leading, .trailing, .firstBaseline, .lastBaseline]
        )
        func toSuperAnchorGuideIndirect(value: NSLayoutConstraint.Attribute) throws {
            let containerView = PlatformView()
            let guide = PlatformLayoutGuide()
            containerView.addLayoutGuide(guide)
            let expectedConstant: CGFloat = 10
            let container = guide.toSuper(
                value,
                constant: expectedConstant
            )
            containerView.activate {
                container
            }

            #expect(1 == container.constraints.count)

            try #require(containerView.constraints.first != nil)
            let constraint = containerView.constraints.first!
            #expect(constraint.isActive)
            #expect(.required == constraint.priority)
            #expect(1 == constraint.multiplier)
            #expect(expectedConstant == constraint.constant)
            #expect(value == constraint.firstAttribute)
        }
    }
}
#endif
