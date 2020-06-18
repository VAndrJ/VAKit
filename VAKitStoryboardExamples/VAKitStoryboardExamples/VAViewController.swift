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
public class VAViewController: UIViewController, VAConstraintable {
    var cWrHConstraints: [NSLayoutConstraint] = []
    var cWcHConstraints: [NSLayoutConstraint] = []
    var rWcHConstraints: [NSLayoutConstraint] = []
    var rWrHConstraints: [NSLayoutConstraint] = []
    
    var rWcHUniqueConstraints: [NSLayoutConstraint] = []
    var cWcHUniqueConstraints: [NSLayoutConstraint] = []
    
    public override func viewDidLoad() {
        saveSortedConstraints()
        super.viewDidLoad()
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard previousTraitCollection?.horizontalSizeClass != traitCollection.horizontalSizeClass ||
            previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass else { return }
        updateConstraints(for: traitCollection)
    }
}
