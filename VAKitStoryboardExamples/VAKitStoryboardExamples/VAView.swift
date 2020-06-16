//
//  VAView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 13.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

/*
 View for easy size class changes handle with VAKit constraints.
 */
open class VAView: UIView, VAConstraintable {
    var cWrHConstraints: [NSLayoutConstraint] = []
    var cWcHConstraints: [NSLayoutConstraint] = []
    
    /*
     Regular width, compact height.
     Devices like large iPhone (XR / 11 Pro Max / etc.) in landscape mode.
     */
    private var rWcHConstraints: [NSLayoutConstraint] = []
    
    /*
     Regular width, regular height.
     Devices like iPad.
     */
    private var rWrHConstraints: [NSLayoutConstraint] = []
    
    private lazy var rWcHUniqueConstraints: [NSLayoutConstraint] = Array(Set(rWcHConstraints).subtracting(cWcHConstraints))
    private lazy var cWcHUniqueConstraints: [NSLayoutConstraint] = Array(Set(cWcHConstraints).subtracting(rWcHConstraints))
    
    open func addElements() {
    }
    
    private func saveConstraintsOf(view: UIView) {
    }
    
    private func updateConstraints(for traitCollection: UITraitCollection) {
    }
}
