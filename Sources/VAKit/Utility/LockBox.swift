//
//  LockBox.swift
//  VAKit
//
//  Created by VAndrJ on 1/29/25.
//

import os.lock

public final class LockBox<Value> {
    public var value: Value {
        os_unfair_lock_lock(lock)
        let result = _value
        os_unfair_lock_unlock(lock)

        return result
    }

    private var _value: Value
    private let lock: UnsafeMutablePointer<os_unfair_lock> = {
        let lock = UnsafeMutablePointer<os_unfair_lock>.allocate(capacity: 1)
        lock.initialize(to: os_unfair_lock())

        return lock
    }()

    public init(value: Value) {
        self._value = value
    }

    public func withValue<Result>(_ block: (Value) -> Result) -> Result {
        os_unfair_lock_lock(lock)
        let result = block(_value)
        os_unfair_lock_unlock(lock)

        return result
    }

    @discardableResult
    public func apply(_ block: (inout Value) -> Value) -> Value {
        os_unfair_lock_lock(lock)
        let result = block(&_value)
        os_unfair_lock_unlock(lock)

        return result
    }

    @discardableResult
    public func modify<Result>(_ block: (inout Value) -> Result) -> Result {
        os_unfair_lock_lock(lock)
        let result = block(&_value)
        os_unfair_lock_unlock(lock)

        return result
    }

    public func update(_ block: (inout Value) -> Void) {
        os_unfair_lock_lock(lock)
        block(&_value)
        os_unfair_lock_unlock(lock)
    }

    deinit {
        lock.deinitialize(count: 1)
        lock.deallocate()
    }
}

extension LockBox: @unchecked Sendable where Value: Sendable {}
