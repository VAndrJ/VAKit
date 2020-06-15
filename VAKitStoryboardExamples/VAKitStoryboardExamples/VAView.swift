//
//  VAView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 13.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

open class VAView: UIView {
    
    /*
     Compact width, regular height.
     Devices like iPhone in portrait orientation
     or iPad split screen in portrait.
     */
    private var cWrHConstraints: [NSLayoutConstraint] = []
    
    /*
     Compact width, compact height.
     Devices like small iPhone (4 / 5 / 6 / etc.) in landscape mode.
     */
    private var cWcHConstraints: [NSLayoutConstraint] = []
    private var rWcHConstraints: [NSLayoutConstraint] = []
    private var rWrHConstraints: [NSLayoutConstraint] = []
    
    private lazy var rWcHUniqueConstraints: [NSLayoutConstraint] = Array(Set(rWcHConstraints).subtracting(cWcHConstraints))
    private lazy var cWcHUniqueConstraints: [NSLayoutConstraint] = Array(Set(cWcHConstraints).subtracting(rWcHConstraints))
}
