//
//  VAButton.swift
//  VAKit
//
//  Created by VAndrJ on 1/27/25.
//

#if canImport(UIKit)
import UIKit

open class VAButton: VASimpleButton {
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
