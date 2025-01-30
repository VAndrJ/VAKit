//
//  DequeueBox.swift
//  VAKit
//
//  Created by VAndrJ on 1/30/25.
//

import Foundation

public final class LockDequeBox<Element> {
    public var first: Element? { lockBox.withValue { $0.first } }
    public var last: Element? { lockBox.withValue { $0.last } }
    public var isEmpty: Bool { count == 0 }
    public var count: Int { lockBox.withValue { $0.count } }

    private let lockBox = LockBox(value: DequeBox<Element>())

    public init() {}

    public func prepend<T: Sequence>(contentsOf sequence: T) where T.Element == Element {
        lockBox.update {
            $0.prepend(contentsOf: sequence)
        }
    }

    public func prepend(_ element: Element) {
        lockBox.update {
            $0.prepend(element)
        }
    }

    public func append<T: Sequence>(contentsOf sequence: T) where T.Element == Element {
        lockBox.update {
            $0.append(contentsOf: sequence)
        }
    }

    public func append(_ element: Element) {
        lockBox.update {
            $0.append(element)
        }
    }

    @discardableResult
    public func popFirst() -> Element? {
        lockBox.modify {
            $0.popFirst()
        }
    }

    @discardableResult
    public func popLast() -> Element? {
        lockBox.modify {
            $0.popLast()
        }
    }
}

extension LockDequeBox: @unchecked Sendable where Element: Sendable {}

public final class DequeBox<Element> {
    private final class Node {
        var value: Element
        var next: Node?
        weak var prev: Node?

        init(value: Element) {
            self.value = value
        }
    }

    public var first: Element? { head?.value }
    public var last: Element? { tail?.value }

    private var head: Node?
    private var tail: Node?
    private(set) var count = 0

    public init() {}

    public func prepend<T: Sequence>(contentsOf sequence: T) where T.Element == Element {
        for element in sequence.reversed() {
            prepend(element)
        }
    }

    public func prepend(_ element: Element) {
        let node = Node(value: element)
        if let head {
            node.next = head
            head.prev = node
        } else {
            tail = node
        }
        head = node
        count += 1
    }

    public func append<T: Sequence>(contentsOf sequence: T) where T.Element == Element {
        for element in sequence {
            append(element)
        }
    }

    public func append(_ element: Element) {
        let node = Node(value: element)
        if let tail {
            tail.next = node
            node.prev = tail
        } else {
            head = node
        }
        tail = node
        count += 1
    }

    @discardableResult
    public func popFirst() -> Element? {
        guard let head else {
            return nil
        }

        self.head = head.next
        if self.head == nil {
            tail = nil
        } else {
            self.head?.prev = nil
        }
        count -= 1

        return head.value
    }

    @discardableResult
    public func popLast() -> Element? {
        guard let tail else {
            return nil
        }

        self.tail = tail.prev
        if self.tail == nil {
            head = nil
        } else {
            self.tail?.next = nil
        }
        count -= 1

        return tail.value
    }
}
