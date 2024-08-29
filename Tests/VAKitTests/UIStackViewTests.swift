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
    func addSubviews() async throws {
        let subview1 = UIView()
        let subview2 = UIView()
        let subview3 = UIView()
        let stackView = UIStackView()
        stackView.addArrangedSubviews(subview1, subview2, subview3)

        #expect([subview1, subview2, subview3] == stackView.subviews)
    }
}
#endif
