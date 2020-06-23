//
//  IPhoneAnySizeDifferentPortraitLandscapeSizeView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 22.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

class IPhoneAnySizeDifferentPortraitLandscapeSizeView: VAView {
    let exampleView = UIView().configured {
        $0.backgroundColor = .purple
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        addElements()
        configure()
    }
    
    private func configure() {
        backgroundColor = .white
    }
    
    override func addElements() {
        addAutolayoutSubview(exampleView)
        exampleView
            .toSuperCenter()
            .size(width: 50, height: 300, device: .iPhonePortrait)
            .size(width: 200, height: 200, device: .iPhoneSmallLandscape)
            .size(width: 400, height: 200, device: .iPhoneLargeLandscape)
        super.addElements()
    }
}

#if DEBUG
#if canImport(SwiftUI)
import SwiftUI

#endif
#endif
