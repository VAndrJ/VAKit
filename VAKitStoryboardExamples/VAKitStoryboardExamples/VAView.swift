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
    var rWcHConstraints: [NSLayoutConstraint] = []
    var rWrHConstraints: [NSLayoutConstraint] = []
    
    var rWcHUniqueConstraints: [NSLayoutConstraint] = []
    var cWcHUniqueConstraints: [NSLayoutConstraint] = []
    
    open func addElements() {
    }
    
    }
    
    private func updateConstraints(for traitCollection: UITraitCollection) {
    }
}
