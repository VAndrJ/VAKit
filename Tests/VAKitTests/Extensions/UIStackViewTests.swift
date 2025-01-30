//
//  UIStackViewTests.swift
//  VAKit
//
//  Created by VAndrJ on 8/29/24.
//

#if canImport(UIKit)
import Testing
import UIKit
@testable import VAKit

@Suite("UIStackView extensions")
@MainActor
struct UIStackViewTests {

    @Test("Add multiple arranged subviews")
    func addSubviews() {
        let subview1 = UIView()
        let subview2 = UIView()
        let subview3 = UIView()
        let stackView = UIStackView()
        stackView.addArrangedSubviews(subview1, subview2, subview3)

        #expect([subview1, subview2, subview3] == stackView.subviews)
    }

    @Test("Add multiple arranged subviews")
    func addSubviewsArray() {
        let subview1 = UIView()
        let subview2 = UIView()
        let subview3 = UIView()
        let stackView = UIStackView()
        stackView.addArrangedSubviewsArray([subview1, subview2, subview3])

        #expect([subview1, subview2, subview3] == stackView.subviews)
    }

    @Test("Remove all subviews")
    func removeSubviews() {
        let subview1 = UIView()
        let subview2 = UIView()
        let subview3 = UIView()
        let stackView = UIStackView()
        stackView.addArrangedSubviewsArray([subview1, subview2, subview3])

        #expect([subview1, subview2, subview3] == stackView.subviews)

        stackView.removeAllArrangedSubviewsDeactivatingConstraints()

        #expect(stackView.subviews.isEmpty)
    }
}
#endif
