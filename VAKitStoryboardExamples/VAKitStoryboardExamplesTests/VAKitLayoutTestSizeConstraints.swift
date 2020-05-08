//
//  VAKitLayoutTestSizeConstraints.swift
//  VAKitStoryboardExamplesTests
//
//  Created by VAndrJ on 07.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutTestSizeConstraints: XCTestCase {
    
    func testFunction_sizeHeight_returnTypeCheck() {
        let view: UIView = MockView().size(height: 10)
        XCTAssertTrue(view is MockView)
    }
}

fileprivate class MockView: UIView {
    
}
