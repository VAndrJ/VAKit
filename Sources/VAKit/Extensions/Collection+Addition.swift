//
//  Collection+Addition.swift
//  VAKit
//
//  Created by VAndrJ on 1/27/25.
//

import Foundation

public extension Collection {
    var isNotEmpty: Bool { !isEmpty }
}

public extension Optional where Wrapped: Collection {
    var isEmpty: Bool { self?.isEmpty ?? true }
    var isNotEmpty: Bool { !isEmpty }
}
