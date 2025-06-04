//
//  ConstraintsDSLExampleView.swift
//  HostingApp
//
//  Created by VAndrJ on 6/4/25.
//

import UIKit
import VAKit

final class ConstraintsDSLExampleView: VAScreenView {
    private let topLabel = UILabel().apply {
        $0.text = "Top"
        $0.font = .preferredFont(forTextStyle: .title3)
    }
    private let topBoxView = UIView().apply {
        $0.backgroundColor = .red
    }
    private let centerLabel = UILabel().apply {
        $0.text = "Center"
        $0.font = .preferredFont(forTextStyle: .body)
    }
    private let centerBoxView = UIView().apply {
        $0.backgroundColor = .orange
    }
    private let bottomLabel = UILabel().apply {
        $0.text = "Bottom"
        $0.font = .preferredFont(forTextStyle: .footnote)
    }
    private let bottomBoxView = UIView().apply {
        $0.backgroundColor = .green
    }

    override func addElements() {
        addAutolayoutSubviews(
            topLabel,
            topBoxView,
            centerLabel,
            centerBoxView,
            bottomLabel,
            bottomBoxView
        )

        activate {
            topLabel
                .toSuper(anchors: .top, .centerX, isSafe: true)
            topBoxView
                .anchor(.centerY, sameTo: topLabel)
                .anchor(.leading, opposedTo: topLabel, constant: 8)
                .size(same: 4)

            centerLabel
                .toSuperCenter()
            centerBoxView
                .anchor(.centerY, sameTo: centerLabel, constant: 8)
                .anchor(.leading, opposedTo: centerLabel)
                .size(CGSize(width: 8, height: 2))

            bottomLabel
                .toSuper(anchors: .centerX, .bottom, isSafe: true)
            bottomBoxView
                .anchor(.centerX, to: bottomLabel, anchor: .leading)
                .anchor(.centerY, to: bottomLabel, anchor: .top)
                .size(same: 4)
        }
    }

    override func configure() {
        backgroundColor = .systemBackground
    }
}

#Preview {
    ConstraintsDSLExampleView().embeddedInController
}
