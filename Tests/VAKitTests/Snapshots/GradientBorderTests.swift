//
//  GradientBorderTests.swift
//  VAKit
//
//  Created by VAndrJ on 5/16/25.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import VAKit

@MainActor
final class CircleSnapshotTests: XCTestCase {

    func test_Shape_GradientBorder() {
        let view = Circle()
            .gradientBorder(colors: [.blue, .yellow], width: 2)
            .frame(size: .init(same: 8))
            .padding(.all, 2)

        assertSnapshot(of: view, as: .image)
    }

    func test_Shape_GradientBorder_CustomPoints() {
        let view = Circle()
            .gradientBorder(
                colors: [.blue, .yellow],
                width: 1,
                startPoint: .leading,
                endPoint: .topTrailing
            )
            .frame(size: .init(same: 4))
            .padding(.all, 2)

        assertSnapshot(of: view, as: .image)
    }

    func test_View_GradientBorder() {
        let view = Text("A")
            .font(.system(size: 4))
            .frame(size: .init(same: 8))
            .gradientBorder(colors: [.blue, .yellow], width: 2)
            .padding(.all, 2)

        assertSnapshot(of: view, as: .image)
    }

    func test_View_GradientBorder_CustomShape() {
        let view = Text("A")
            .font(.system(size: 4))
            .frame(size: .init(same: 8))
            .gradientBorder(
                colors: [.blue, .yellow],
                width: 1,
                shape: Rectangle()
            )
            .padding(.all, 2)

        assertSnapshot(of: view, as: .image)
    }

    func test_View_GradientBorder_CustomShape_CustomPoints() {
        let view = Text("A")
            .font(.system(size: 4))
            .frame(size: .init(same: 8))
            .gradientBorder(
                colors: [.blue, .yellow],
                width: 1,
                shape: RoundedRectangle(cornerRadius: 2),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .padding(.all, 1)

        assertSnapshot(of: view, as: .image)
    }
}
