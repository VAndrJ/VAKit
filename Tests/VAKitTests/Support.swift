//
//  Support.swift
//  VAKit
//
//  Created by VAndrJ on 5/15/25.
//

import Foundation

@available(iOS 16.0, *)
final class AsyncExpectation: Sendable {
    enum AsyncExpectationError: Error {
        case timedOut
    }

    private let stream = AsyncStream<Void>.makeStream()

    func fulfill() {
        stream.continuation.yield()
        stream.continuation.finish()
    }

    func wait() async {
        for await _ in stream.stream {
            break
        }
    }

    func wait(timeout: Duration) async throws {
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.wait()
            }
            group.addTask {
                try? await Task.sleep(for: timeout)
                guard !Task.isCancelled else { return }

                throw AsyncExpectationError.timedOut
            }

            try await group.next()
            group.cancelAll()
        }
    }

    func wait(resumeIn: Duration) async {
        try? await wait(timeout: resumeIn)
    }
}

#if canImport(SwiftUI)
import SwiftUI
import Testing

@MainActor
func getViewResult<T>(
    timeout: TimeInterval = 1,
    @ViewBuilder content: @MainActor (@MainActor @escaping (_ emit: sending T) -> Void) -> some View
) async throws -> T {
    return try await withCheckedThrowingContinuation { continuation in
        let expectation = WindowExpectationRunner()
        expectation.layout(view: content { value in
            continuation.resume(returning: value)
            expectation.fulfill()
        })
        do {
            try expectation.wait(timeout: 1)
        } catch {
            continuation.resume(throwing: error)
        }
    }
}

private enum ExpectationError: Error, LocalizedError {
    case timeout

    var localizedDescription: String {
        switch self {
        case .timeout: "Expectation timed out"
        }
    }
}

@MainActor
private class WindowExpectationRunner {
    private(set) var isFulfilled = false
    var window: UIWindow?

    func layout(view: some View) {
        window = TestHostingWindow(view: view)
    }

    func fulfill() {
        isFulfilled = true
    }

    func wait(interval: TimeInterval = 0.05, timeout: TimeInterval) throws {
        let timeoutDate = Date().addingTimeInterval(timeout)
        while !isFulfilled && Date() < timeoutDate {
            RunLoop.current.run(until: Date().addingTimeInterval(interval))
        }
        if !isFulfilled {
            throw ExpectationError.timeout
        }
    }
}

private class TestHostingWindow: UIWindow {

    init(view: some View) {
        super.init(frame: .init(x: 0, y: 0, width: 320, height: 568))

        let hosting = UIHostingController(rootView: view)
        rootViewController = hosting
        makeKeyAndVisible()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
