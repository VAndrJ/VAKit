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
    
    private lazy var rWcHUniqueConstraints: [NSLayoutConstraint] = Array(Set(rWcHConstraints).subtracting(cWcHConstraints))
    private lazy var cWcHUniqueConstraints: [NSLayoutConstraint] = Array(Set(cWcHConstraints).subtracting(rWcHConstraints))
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard previousTraitCollection?.horizontalSizeClass != traitCollection.horizontalSizeClass ||
            previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass else { return }
        updateConstraints(for: traitCollection)
    }
    
    private func saveSortedConstraints(from view: UIView) {
        view.constraints.forEach({ constraint in
            switch constraint.identifier {
            case UIView.VADevice.iPhonePortrait.rawValue, UIView.VADevice.iPadSplitPortrait.rawValue:
                cWrHConstraints.append(constraint)
            case UIView.VADevice.iPhoneLandscape.rawValue:
                cWcHConstraints.append(constraint)
                rWcHConstraints.append(constraint)
            case UIView.VADevice.iPhoneLargeLandscape.rawValue:
                rWcHConstraints.append(constraint)
            case UIView.VADevice.iPhoneSmallLandscape.rawValue:
                cWcHConstraints.append(constraint)
            case UIView.VADevice.iPad.rawValue:
                rWrHConstraints.append(constraint)
            default:
                break
            }
        })
        view.subviews.forEach(saveSortedConstraints(from:))
    }
    
    private func updateConstraints(for traitCollection: UITraitCollection) {
        func deactivate(constraints: [NSLayoutConstraint]...) {
            constraints.forEach(NSLayoutConstraint.deactivate)
        }
        func activate(constraints: [NSLayoutConstraint]) {
            NSLayoutConstraint.activate(constraints)
        }
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.compact, .compact):
            deactivate(constraints: cWrHConstraints, rWrHConstraints, rWcHUniqueConstraints)
            activate(constraints: cWcHConstraints)
        case (.regular, .compact):
            deactivate(constraints: rWrHConstraints, cWrHConstraints, cWcHUniqueConstraints)
            activate(constraints: rWcHConstraints)
        case (.regular, .regular):
            deactivate(constraints: rWcHConstraints, cWcHConstraints, cWrHConstraints)
            activate(constraints: rWrHConstraints)
        default:
            deactivate(constraints: cWcHConstraints, rWcHConstraints, rWrHConstraints)
            activate(constraints: cWrHConstraints)
        }
    }
}
