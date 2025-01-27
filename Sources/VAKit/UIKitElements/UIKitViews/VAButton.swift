//
//  VAButton.swift
//  VAKit
//
//  Created by VAndrJ on 1/27/25.
//

#if canImport(UIKit)
import UIKit
import Combine

open class VAButton: VASimpleButton {
    public var onTapPubl: AnyPublisher<Void, Never> {
        let subject = PassthroughSubject<Void, Never>()
        onTap = {
            subject.send(())
        }

        return subject.eraseToAnyPublisher()
    }
    public var onTap: (() -> Void)? {
        didSet {
            removeTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
            if onTap != nil {
                addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
            }
        }
    }

    public func onTap<T: AnyObject>(_ target: T?, action: @escaping (T) -> Void) {
        onTap = { [weak target] in
            guard let target else { return }

            action(target)
        }
    }

    @objc private func onButtonTap() {
        onTap?()
    }
}
#endif
