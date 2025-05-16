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

@Suite("GeometryProxy extensions")
struct GeometryProxyTests {

    @Test(
        "GeometryProxy center depending on size",
        arguments: [
            (CGSize(same: 100), CGPoint(xy: 50)),
            (CGSize(width: 20, height: 10), CGPoint(x: 10, y: 5)),
            (CGSize(same: 0), CGPoint(xy: 0)),
            (CGSize(width: 10, height: 20), CGPoint(x: 5, y: 10)),
            (CGSize(same: 1000), CGPoint(xy: 500)),
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

    @available(iOS 17.0, *)
    @Test(
        "GeometryProxy size with Safe Area",
        arguments: [
            (CGSize(same: 100), EdgeInsets(all: 10)),
            (CGSize(same: 100), EdgeInsets()),
            (CGSize(width: 25, height: 30), EdgeInsets(all: 10)),
            (CGSize(width: 25, height: 30), EdgeInsets()),
        ]
    )
    func sizeWithSafeArea(size: CGSize, safeArea: EdgeInsets) async throws {
        let sizeWithSafe = try await getViewResult { emit in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        emit(proxy.sizeWithSafeArea)
                    }
            }
            .safeAreaPadding(safeArea)
            .frame(width: size.width, height: size.height)
        }
        #expect(size == sizeWithSafe)
    }

    @Test(
        "GeometryProxy size fraction",
        arguments: [
            (CGSize(same: 100), GeometryProxy.Dimension.width, 0.3, 30),
            (CGSize(same: 100), GeometryProxy.Dimension.height, 0.3, 30),
            (CGSize(same: 100), GeometryProxy.Dimension.width, 1, 100),
            (CGSize(same: 100), GeometryProxy.Dimension.height, 1, 100),
            (CGSize(same: 100), GeometryProxy.Dimension.width, 2, 100),
            (CGSize(same: 100), GeometryProxy.Dimension.height, 2, 100),
            (CGSize(same: 100), GeometryProxy.Dimension.width, 0, 0),
            (CGSize(same: 100), GeometryProxy.Dimension.height, 0, 0),
            (CGSize(same: 100), GeometryProxy.Dimension.width, -1, 0),
            (CGSize(same: 100), GeometryProxy.Dimension.height, -1, 0),
        ]
    )
    func fraction(size: CGSize, dimension: GeometryProxy.Dimension, value: CGFloat, expected: CGFloat) async throws {
        let fraction = try await getViewResult { emit in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        emit(proxy.fraction(dimension, value: value))
                    }
            }
            .frame(width: size.width, height: size.height)
        }
        #expect(expected == fraction)
    }
}
#endif
