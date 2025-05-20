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
    public func run(tag: Tag, block: @escaping () async -> Void) async -> Bool {
        guard self.tag == nil else {
            return false
        }

        self.tag = tag
        defer { self.tag = nil }
        await block()

        return true
    }
}
