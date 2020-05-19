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
}
