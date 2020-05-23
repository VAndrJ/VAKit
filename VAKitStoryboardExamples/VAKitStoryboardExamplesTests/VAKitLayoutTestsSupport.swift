//
//  VAKitLayoutTestsSupport.swift
//  VAKitStoryboardExamplesTests
//
//  Created by Vladimir Andrienko on 23.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit
import XCTest

func constraintPriorityCheck(constraint: NSLayoutConstraint?, priority: Float, file: StaticString = #file, line: UInt = #line) {
    XCTAssertNotNil(constraint, file: file, line: line)
    XCTAssertEqual(priority, constraint!.priority.rawValue, file: file, line: line)
}

class MockView: UIView {
    
}
