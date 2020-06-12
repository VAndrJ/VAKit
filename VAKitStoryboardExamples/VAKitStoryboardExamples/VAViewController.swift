//
//  VAViewController.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 11.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

/*
 Controller for easy size class changes handle with VAKit constraints.
 */
class VAViewController: UIViewController {
    
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
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    private func updateConstraints(for traitCollection: UITraitCollection) {
        func deactivate(constraints: [NSLayoutConstraint]...) {
            constraints.forEach(NSLayoutConstraint.deactivate)
        }
        func activate(constraints: [NSLayoutConstraint]) {
            NSLayoutConstraint.activate(constraints)
        }
    }
}
