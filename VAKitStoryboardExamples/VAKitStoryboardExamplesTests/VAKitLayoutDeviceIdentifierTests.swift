//
//  VAKitLayoutDeviceIdentifierTests.swift
//  VAKitStoryboardExamplesTests
//
//  Created by VAndrJ on 16.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutDeviceIdentifierTests: XCTestCase {
    var view: UIView!
    
    override func setUp() {
        view = UIView()
    }
    
    override func tearDown() {
        view = nil
    }
    
    func test_sizeHeight_identifier() {
        var constraint: NSLayoutConstraint!
        view.size(height: 10, configuring: { constraint = $0 })
        XCTAssertEqual(UIView.VADevice.unspecified.rawValue, constraint.identifier)
    }
    
    func test_sizeHeight_identifierCunstom() {
    }
}
