//
//  ViewTests.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

#if canImport(SwiftUI)
import Testing
import SwiftUI
@testable import VAKit

@Suite("View extensions")
struct ViewTests {

    @Test(
        "Frame with size",
        arguments: [
            CGSize(same: 1000),
            CGSize(same: 100),
            CGSize(same: 0),
            CGSize(width: 100, height: 1000),
            CGSize(width: 1000, height: 100),
            CGSize(width: 100, height: 0),
            CGSize(width: 0, height: 100),
        ]
    )
    func frameSize(size: CGSize) async throws {
        let viewSize = try await getViewResult { emit in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        emit(proxy.size)
                    }
            }
            .frame(size: size)
        }
        #expect(size == viewSize)
    }
}
#endif
