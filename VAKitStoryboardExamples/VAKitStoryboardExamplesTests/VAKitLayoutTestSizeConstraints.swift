//
//  VAKitLayoutTestSizeConstraints.swift
//  VAKitStoryboardExamplesTests
//
//  Created by VAndrJ on 07.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutTestSizeConstraints: XCTestCase {
    var view: UIView!
    
    override func setUp() {
        view = UIView()
    }
    
    override func tearDown() {
        view = nil
    }
    
    func testFunction_sizeHeight_returnTypeCheck() {
        view = MockView().size(height: 10)
        XCTAssertTrue(view is MockView)
    }
    
    func testFunction_sizeHeight_constraintWithConstantSet() {
    }
}

fileprivate class MockView: UIView {
    
}
