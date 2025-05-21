//
//  Optional+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 5/21/25.
//

extension Optional {
    
    func mapOr<U>(_ transform: (Wrapped) -> U, default fallback: @autoclosure () -> U) -> U {
        return map(transform) ?? fallback()
    }
}
