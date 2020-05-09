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
    var parentView: UIView!
    
    override func setUp() {
        view = UIView()
        parentView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    }
    
    override func tearDown() {
        view = nil
        parentView = nil
    }
    
    func testFunction_sizeHeight_returnTypeCheck() {
        view = MockView().size(height: 10)
        XCTAssertTrue(view is MockView)
    }
    
    func testFunction_sizeHeight_constraintWithConstantSet() {
        let height: CGFloat = 10
        view.size(height: height)
        layoutViews()
        XCTAssertEqual(height, view.frame.height)
    }
    
    func testFunction_sizeHeight_constraintPriority() {
    }
    
    private func layoutViews() {
        parentView.addAutolayoutSubview(view)
        parentView.setNeedsLayout()
        parentView.layoutIfNeeded()
    }
}

fileprivate class MockView: UIView {
    
}
