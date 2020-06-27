//
//  DifferentPortraitLandscapeAnyPhoneSizePadSameView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 27.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

class DifferentPortraitLandscapeAnyPhoneSizePadSameView: VAView {
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        addElements()
        configure()
    }
    
    private func configure() {
        backgroundColor = .white
    }
    
    override func addElements() {
        
        super.addElements()
    }
}
