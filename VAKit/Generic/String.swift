//
//  String.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 20.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import Foundation

extension String {
    var ns: NSString {
        return self as NSString
    }
    var lastPathComponent: String {
        return ns.lastPathComponent
    }
}
