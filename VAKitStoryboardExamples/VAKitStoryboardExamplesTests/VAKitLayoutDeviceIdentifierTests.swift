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
    
    func test_sizeHeight_identifierDefault() {
        var constraint: NSLayoutConstraint!
        view.size(height: 10, configuring: { constraint = $0 })
        XCTAssertEqual(UIView.VADevice.unspecified.rawValue, constraint.identifier)
    }
    
    func test_sizeHeight_identifierCustom() {
        let device: UIView.VADevice = .iPhonePortrait
        var constraint: NSLayoutConstraint!
        view.size(height: 10, device: device, configuring: { constraint = $0 })
        XCTAssertEqual(device.rawValue, constraint.identifier)
    }
    
    func test_sizeWidth_identifierDefault() {
        var constraint: NSLayoutConstraint!
        view.size(width: 10, configuring: { constraint = $0 })
        XCTAssertEqual(UIView.VADevice.unspecified.rawValue, constraint.identifier)
    }
    
    func test_sizeWidth_identifierCustom() {
        let device: UIView.VADevice = .iPhonePortrait
        var constraint: NSLayoutConstraint!
        view.size(width: 10, device: device, configuring: { constraint = $0 })
        XCTAssertEqual(device.rawValue, constraint.identifier)
    }
    
    func test_size_identifierDefault() {
        var widthConstraint: NSLayoutConstraint!
        var heightConstraint: NSLayoutConstraint!
        view.size(10, configuring: { (widthConstraint, heightConstraint) = $0 })
        XCTAssertEqual(UIView.VADevice.unspecified.rawValue, widthConstraint.identifier)
        XCTAssertEqual(UIView.VADevice.unspecified.rawValue, heightConstraint.identifier)
    }
    
    func test_size_identifierCustom() {
        let device: UIView.VADevice = .iPhonePortrait
        var widthConstraint: NSLayoutConstraint!
        var heightConstraint: NSLayoutConstraint!
        view.size(10, device: device, configuring: { (widthConstraint, heightConstraint) = $0 })
        XCTAssertEqual(device.rawValue, widthConstraint.identifier)
        XCTAssertEqual(device.rawValue, heightConstraint.identifier)
    }
    
    func test_toSuper_identifierDefault() {
        var constraint: NSLayoutConstraint!
        let parentView = UIView()
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, configuring: { constraint = $0 })
        XCTAssertEqual(UIView.VADevice.unspecified.rawValue, constraint.identifier)
    }
    
    func test_toSuper_identifierCustom() {
        let device: UIView.VADevice = .iPhonePortrait
        var constraint: NSLayoutConstraint!
        let parentView = UIView()
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, device: device, configuring: { constraint = $0 })
        XCTAssertEqual(device.rawValue, constraint.identifier)
    }
    
    func test_toSuperCenter_identifierDefault() {
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        let parentView = UIView()
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertEqual(UIView.VADevice.unspecified.rawValue, constraintCenterX.identifier)
        XCTAssertEqual(UIView.VADevice.unspecified.rawValue, constraintCenterY.identifier)
    }
    
    func test_toSuperCenter_identifierCustom() {
        let device: UIView.VADevice = .iPhonePortrait
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        let parentView = UIView()
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(device: device, configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertEqual(device.rawValue, constraintCenterX.identifier)
        XCTAssertEqual(device.rawValue, constraintCenterY.identifier)
    }
}
