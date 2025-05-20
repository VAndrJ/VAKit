//
//  ExclusiveTaskRunnerTests.swift
//  VAKit
//
//  Created by VAndrJ on 5/20/25.
//

import Testing
import Foundation
@testable import VAKit

@Suite
@MainActor
struct ExclusiveTaskRunnerTests {

    @Test("Run task when idle")
    @MainActor
    func runsWhenIdle() async throws {
        let runner = ExclusiveTaskRunner<Int>()
        let tag = 1
        var executed = false

        let accepted = await runner.run(tag: tag) {
            executed = true
        }

        #expect(accepted == true)
        #expect(executed == true)
        #expect(runner.tag == nil)
    }

    @available(iOS 16.0, *)
    @Test("Run heavy task when idle")
    @MainActor
    func runsHeavyWhenIdle() async throws {
        let runner = ExclusiveTaskRunner<Int>()
        let tag = 1

        let accepted = await runner.run(tag: tag) {
            try? await Task.sleep(for: .seconds(1))
        }

        #expect(accepted == true)
        #expect(runner.tag == nil)
    }

    @Test
    @MainActor
    func runsSequential() async {
        let runner = ExclusiveTaskRunner<Int>()
        var output: [String] = []

        let accepted1 = await runner.run(tag: 1) {
            output.append("A")
        }
        let accepted2 = await runner.run(tag: 2) {
            output.append("B")
        }

        #expect(accepted1 == true)
        #expect(accepted2 == true)
        #expect(output == ["A", "B"])
        #expect(runner.tag == nil)
    }

    @Test
    @MainActor
    func runsAndRejectsTaskWhileRunning() async throws {
        let runner = ExclusiveTaskRunner<Int>()
        let tag1 = 1
        let tag2 = 2
        let startSignal = AsyncStream<Void>.makeStream()
        let continueSignal = AsyncStream<Void>.makeStream()
        var firstExecuted = false
        var secondExecuted = false

        let task1 = Task {
            await runner.run(tag: tag1) {
                firstExecuted = true
                startSignal.continuation.yield(())
                for await _ in continueSignal.stream {
                    break
                }
            }
        }
        for await _ in startSignal.stream {
            break
        }
        let accepted2 = await runner.run(tag: tag2) {
            secondExecuted = true
        }
        continueSignal.continuation.yield(())
        _ = await task1.value

        #expect(firstExecuted == true)
        #expect(accepted2 == false)
        #expect(secondExecuted == false)
        #expect(runner.tag == nil)
    }
}
