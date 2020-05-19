//
//  VAKitLayoutVADeviceTests.swift
//  VAKitStoryboardExamplesTests
//
//  Created by Vladimir Andrienko on 19.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutVADeviceTests: XCTestCase {
    
    func test_VADevice_allCasesInit() {
        UIView.VADevice.allCases.forEach({ device in
            XCTAssertEqual(device, UIView.VADevice(identifier: device.rawValue))
        })
    }
    
    func test_VADevice_nilIdentifier() {
        let device = UIView.VADevice(identifier: nil)
        XCTAssertEqual(UIView.VADevice.unspecified, device)
    }
    
    func test_VADevice_randomStringIdentifier() {
        let device = UIView.VADevice(identifier: "qwerty")
        XCTAssertEqual(UIView.VADevice.unspecified, device)
    }
}
