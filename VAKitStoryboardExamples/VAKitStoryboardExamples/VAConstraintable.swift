//
//  VAConstraintable.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 16.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

protocol VAConstraintable: AnyObject {
    
    /*
     Compact width, regular height.
     Devices like iPhone in portrait orientation
     or iPad split screen in portrait.
     */
    var cWrHConstraints: [NSLayoutConstraint] { get set }
    
    /*
     Compact width, compact height.
     Devices like small iPhone (4 / 5 / 6 / etc.) in landscape mode.
     */
    var cWcHConstraints: [NSLayoutConstraint] { get set }
    
    /*
     Regular width, compact height.
     Devices like large iPhone (XR / 11 Pro Max / etc.) in landscape mode.
     */
    var rWcHConstraints: [NSLayoutConstraint] { get set }
    
    /*
     Regular width, regular height.
     Devices like iPad.
     */
    var rWrHConstraints: [NSLayoutConstraint] { get set }
    
    /*
     Unique constraints for large iPhones landscape mode.
     */
    var rWcHUniqueConstraints: [NSLayoutConstraint] { get set }
    
    /*
     Unique constraints for small iPhones landscape mode.
     */
    var cWcHUniqueConstraints: [NSLayoutConstraint] { get set }
    
    /// Function to save constraints from views to prepared arrays
    /// - Parameter view: view to save constraints from
    func saveSortedConstraintsOf(view: UIView)
    
    /// Function to update constraints for new trait collection
    /// - Parameter traitCollection: UITraitCollection
    func updateConstraints(for traitCollection: UITraitCollection)
}

extension VAConstraintable {
    
    func saveSortedConstraintsOf(view: UIView) {
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
        view.subviews.forEach(saveSortedConstraintsOf(view:))
    }
    
    func updateConstraints(for traitCollection: UITraitCollection) {
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
