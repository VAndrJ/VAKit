//
//  Collection+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 1/27/25.
//

import Foundation

extension Collection {
    public var isNotEmpty: Bool { !isEmpty }
}

extension Optional where Wrapped: Collection {
    public var isEmpty: Bool { self?.isEmpty ?? true }
    public var isNotEmpty: Bool { !isEmpty }
}
