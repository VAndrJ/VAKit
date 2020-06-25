//
//  DifferentPortraitLandscapeAnyPhoneSizeViewController.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 12.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

class DifferentPortraitLandscapeAnyPhoneSizeViewController: UIViewController {
    let contentsView: DifferentPortraitLandscapeAnyPhoneSizeView
    
    init(contentsView: DifferentPortraitLandscapeAnyPhoneSizeView) {
        self.contentsView = contentsView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentsView
    }
}
