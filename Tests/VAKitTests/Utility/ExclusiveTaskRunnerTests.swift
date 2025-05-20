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
            try? await Task.sleep(for: .milliseconds(100))
        }

        #expect(accepted == true)
        #expect(runner.tag == nil)
    }

    @Test("Run tasks sequentially")
    @MainActor
    func runsSequentially() async {
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

    @available(iOS 16.0, *)
    @Test("Run task and reject next while running")
    @MainActor
    func runsAndRejectsTaskWhileRunning() async throws {
        let runner = ExclusiveTaskRunner<Int>()
        let tag1 = 1
        let tag2 = 2
        let startExpectation = AsyncExpectation()
        let continueExpectation = AsyncExpectation()
        var firstExecuted = false
        var secondExecuted = false

        let task1 = Task {
            await runner.run(tag: tag1) {
                firstExecuted = true
                startExpectation.fulfill()
                await continueExpectation.wait()
            }
        }
        await startExpectation.wait()
        let accepted2 = await runner.run(tag: tag2) {
            secondExecuted = true
        }
        continueExpectation.fulfill()
        _ = await task1.value

        #expect(firstExecuted == true)
        #expect(accepted2 == false)
        #expect(secondExecuted == false)
        #expect(runner.tag == nil)
    }
}

@Suite
@MainActor
struct ExclusiveTaskLauncherTests {

    @available(iOS 16.0, *)
    @Test("Run task when idle")
    @MainActor
    func runsWhenIdle() async throws {
        let runner = ExclusiveTaskLauncher()
        var executed = false
        let expectation = AsyncExpectation()

        let accepted = runner.run {
            try? await Task.sleep(for: .milliseconds(100))
            executed = true
            expectation.fulfill()
        }
        await expectation.wait()

        #expect(accepted == true)
        #expect(executed == true)
        #expect(runner.currentTask == nil)
    }

    @available(iOS 16.0, *)
    @Test("Run task and reject next while running")
    @MainActor
    func runsAndRejectsTaskWhileRunning() async throws {
        let runner = ExclusiveTaskLauncher()
        var firstExecuted = false
        var secondExecuted = false
        let expectation = AsyncExpectation()

        let accepted1 = runner.run {
            try? await Task.sleep(for: .milliseconds(200))
            firstExecuted = true
            expectation.fulfill()
        }
        let accepted2 = runner.run {
            secondExecuted = true
            expectation.fulfill()
        }
        await expectation.wait()

        #expect(accepted1 == true)
        #expect(accepted2 == false)
        #expect(firstExecuted == true)
        #expect(secondExecuted == false)
        #expect(runner.currentTask == nil)
    }

    @available(iOS 16.0, *)
    @Test("Run task, cancel it and run next task")
    @MainActor
    func runsAndRunNextAfterCancellation() async throws {
        let runner = ExclusiveTaskLauncher()
        var firstExecuted = false
        var secondExecuted = false
        let expectation = AsyncExpectation()

        let accepted1 = runner.run {
            try? await Task.sleep(for: .milliseconds(50))
            guard !Task.isCancelled else { return }

            firstExecuted = true
            expectation.fulfill()
        }
        runner.cancel()
        let accepted2 = runner.run {
            try? await Task.sleep(for: .milliseconds(200))
            secondExecuted = true
            expectation.fulfill()
        }
        await expectation.wait()

        #expect(accepted1 == true)
        #expect(accepted2 == true)
        #expect(firstExecuted == false)
        #expect(secondExecuted == true)
        #expect(runner.currentTask == nil)
    }
}
