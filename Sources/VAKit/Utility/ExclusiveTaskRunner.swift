//
//  ExclusiveTaskRunner.swift
//  VAKit
//
//  Created by VAndrJ on 5/20/25.
//

@MainActor
public final class ExclusiveTaskRunner<Tag: Equatable> {
    public private(set) var tag: Tag?

    @discardableResult
    public func run(tag: Tag, operation: @escaping () async -> Void) async -> Bool {
        guard self.tag == nil else {
            return false
        }

        self.tag = tag
        defer { self.tag = nil }
        await operation()

        return true
    }
}

@MainActor
public final class ExclusiveTaskLauncher {
    private(set) var currentTask: Task<Void, Never>?

    @discardableResult
    public func run(_ operation: @escaping () async -> Void) -> Bool {
        guard currentTask == nil else {
            return false
        }

        currentTask = Task { [weak self] in
            defer { self?.clear() }
            await operation()
        }

        return true
    }

    public func cancel() {
        currentTask?.cancel()
        clear()
    }

    private func clear() {
        currentTask = nil
    }
}
