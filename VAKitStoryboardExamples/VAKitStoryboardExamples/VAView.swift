//
//  VAView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 13.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

class VAView: UIView {
    private var cWrHConstraints: [NSLayoutConstraint] = []
    private var cWcHConstraints: [NSLayoutConstraint] = []
    private var rWcHConstraints: [NSLayoutConstraint] = []
    private var rWrHConstraints: [NSLayoutConstraint] = []
    
    private lazy var rWcHUniqueConstraints: [NSLayoutConstraint] = Array(Set(rWcHConstraints).subtracting(cWcHConstraints))
    private lazy var cWcHUniqueConstraints: [NSLayoutConstraint] = Array(Set(cWcHConstraints).subtracting(rWcHConstraints))
}
