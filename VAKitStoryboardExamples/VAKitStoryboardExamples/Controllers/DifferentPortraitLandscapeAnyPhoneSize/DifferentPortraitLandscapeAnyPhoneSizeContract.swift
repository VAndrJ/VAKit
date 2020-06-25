//
//  DifferentPortraitLandscapeAnyPhoneSizeContract.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 24.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

/*
 Not important for example
 */
struct DifferentPortraitLandscapeAnyPhoneSizeConfigurator {
    let controller: UIViewController
    
    init() {
        self.controller = DifferentPortraitLandscapeAnyPhoneSizeViewController(contentsView: DifferentPortraitLandscapeAnyPhoneSizeView())
    }
}
