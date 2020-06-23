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
    
    /// Override this function to add elements and then call super.addElements()
    open func addElements() {
        saveSortedConstraints()
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard previousTraitCollection?.horizontalSizeClass != traitCollection.horizontalSizeClass ||
            previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass else { return }
        updateConstraints(for: traitCollection)
    }
}
