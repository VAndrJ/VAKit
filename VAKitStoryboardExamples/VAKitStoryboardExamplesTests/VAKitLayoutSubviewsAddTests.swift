//
//  VAKitLayoutSubviewsAddTests.swift
//  VAKitStoryboardExamplesTests
//
//  Created by VAndrJ on 05.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutSubviewsAddTests: XCTestCase {
    
    func testFunction_addSubviews_withSingleView() throws {
        let parentView = UIView()
        let testView = UIView()
        parentView.addSubviews(testView)
        XCTAssertEqual(parentView, testView.superview)
    }
    
    func testFunction_addSubviews_withMultipleViews() throws {
        let parentView = UIView()
        let testView = UIView()
        let testView1 = UIView()
        parentView.addSubviews(testView, testView1)
        XCTAssertEqual(parentView, testView.superview)
        XCTAssertEqual(parentView, testView1.superview)
    }
}
