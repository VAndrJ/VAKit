//
//  Configurable.swift
//  VAKit
//
//  Created by VAndrJ on 07.04.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import Foundation

protocol Configurable {}

extension Configurable {
    
    func configured(_ configure: (Self) throws -> Void) rethrows -> Self {
        try configure(self)
        return self
    }
}

extension NSObject: Configurable {}
