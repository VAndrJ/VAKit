//
//  VAKitLayoutSuperConstraintsTests.swift
//  VAKitStoryboardExamplesTests
//
//  Created by Vladimir Andrienko on 23.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutSuperConstraintsTests: XCTestCase {
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
    
    func test_toSuper_returnViewType() {
        view = MockView()
        parentView.addAutolayoutSubview(view)
        let testView = view.toSuper(.top)
        XCTAssertTrue(testView is MockView)
    }
}
