//
//  GeometryProxyTests.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

#if canImport(SwiftUI)
import SwiftUI
import Testing
@testable import VAKit

@Suite
struct GeometryProxyTests {

    @Test(
        "GeometryProxy center depending on size",
        arguments: [
            (CGSize(same: 100), CGPoint(x: 50, y: 50)),
            (CGSize(width: 20, height: 10), CGPoint(x: 10, y: 5)),
            (CGSize(same: 0), CGPoint(x: 0, y: 0)),
            (CGSize(width: 10, height: 20), CGPoint(x: 5, y: 10)),
            (CGSize(same: 1000), CGPoint(x: 500, y: 500)),
        ]
    )
    func center(size: CGSize, expected: CGPoint) async throws {
        let center = try await getViewResult { emit in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        emit(proxy.center)
                    }
            }
            .frame(width: size.width, height: size.height)
        }
        #expect(expected == center)
    }
}
#endif
