//
//  VAKitLayoutSubviewsAddTests.swift
//  VAKitStoryboardExamplesTests
//
//  Created by VAndrJ on 05.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutSubviewsAddTests: XCTestCase {
    
    func testFunction_addSubviews_withSingleView() {
        let parentView = UIView()
        let testView = UIView()
        parentView.addSubviews(testView)
        XCTAssertEqual(parentView, testView.superview)
    }
    
    func testFunction_addSubviews_withMultipleViews() {
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
        XCTAssertEqual(parentView, testView.superview)
        XCTAssertEqual(false, testView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testFunction_addAutolayoutSubviews_withSingleView() {
        let parentView = UIView()
        let testView = UIView()
        parentView.addAutolayoutSubviews(testView)
        XCTAssertEqual(parentView, testView.superview)
        XCTAssertEqual(false, testView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testFunction_addAutolayoutSubviews_withMultipleViews() {
        let parentView = UIView()
        let testView = UIView()
        let testView1 = UIView()
        parentView.addAutolayoutSubviews(testView, testView1)
        XCTAssertEqual(parentView, testView.superview)
        XCTAssertEqual(false, testView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(parentView, testView1.superview)
        XCTAssertEqual(false, testView1.translatesAutoresizingMaskIntoConstraints)
    }
    
    private func addAutolayoutSubviewTestCheck(parentView: UIView, childView: UIView, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(parentView, childView.superview, file: file, line: line)
        XCTAssertEqual(false, childView.translatesAutoresizingMaskIntoConstraints, file: file, line: line)
    }
}
