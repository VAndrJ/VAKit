//
//  VAKitLayoutSubviewsAddTests.swift
//  VAKitStoryboardExamplesTests
//
//  Created by VAndrJ on 05.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutSubviewsAddTests: XCTestCase {
    
    func test_addSubviews_withSingleView() {
        let parentView = UIView()
        let testView = UIView()
        parentView.addSubviews(testView)
        XCTAssertEqual(parentView, testView.superview)
    }
    
    func test_addSubviews_withMultipleViews() {
        let parentView = UIView()
        let testView = UIView()
        let testView1 = UIView()
        parentView.addSubviews(testView, testView1)
        XCTAssertEqual(parentView, testView.superview)
        XCTAssertEqual(parentView, testView1.superview)
    }
    
    func testFunction_addAutolayoutSubview() {
        let parentView = UIView()
        let testView = UIView()
        parentView.addAutolayoutSubview(testView)
        addAutolayoutSubviewTestCheck(parentView: parentView, childView: testView)
    }
    
    func testFunction_addAutolayoutSubviews_withSingleView() {
        let parentView = UIView()
        let testView = UIView()
        parentView.addAutolayoutSubviews(testView)
        addAutolayoutSubviewTestCheck(parentView: parentView, childView: testView)
    }
    
    func testFunction_addAutolayoutSubviews_withMultipleViews() {
        let parentView = UIView()
        let testView = UIView()
        let testView1 = UIView()
        parentView.addAutolayoutSubviews(testView, testView1)
        addAutolayoutSubviewTestCheck(parentView: parentView, childView: testView)
        addAutolayoutSubviewTestCheck(parentView: parentView, childView: testView1)
    }
    
    private func addAutolayoutSubviewTestCheck(parentView: UIView, childView: UIView, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(parentView, childView.superview, file: file, line: line)
        XCTAssertEqual(false, childView.translatesAutoresizingMaskIntoConstraints, file: file, line: line)
    }
}
