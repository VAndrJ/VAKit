//
//  CALayerAnimationsExamplesView.swift
//  HostingApp
//
//  Created by VAndrJ on 6/4/25.
//

import UIKit
import VAKit

final class CALayerAnimationsExamplesView: VAScreenView {
    private let xRotationLabel = UILabel().apply {
        $0.text = "xX"
    }
    private let yRotationLabel = UILabel().apply {
        $0.text = "yY"
    }
    private let zRotationLabel = UILabel().apply {
        $0.text = "zZ"
    }
    private let mixedRotationLabel = UILabel().apply {
        $0.text = "Mix"
    }

    override func addElements() {
        addAutolayoutSubviews(
            xRotationLabel,
            yRotationLabel,
            zRotationLabel,
            mixedRotationLabel
        )

        activate {
            Row(main: .centerEvently, cross: .center) {
                xRotationLabel
                yRotationLabel
                zRotationLabel
                mixedRotationLabel
            }
        }
    }

    override func configure() {
        backgroundColor = .systemBackground
    }

    override func willAppear(_ animated: Bool) {
        xRotationLabel.animate(
            .rotationX(from: 0, to: .pi * 2),
            duration: 2,
            repeatCount: .infinity
        )
        yRotationLabel.animate(
            .rotationY(from: 0, to: .pi * 2),
            duration: 2,
            repeatCount: .infinity
        )
        zRotationLabel.animate(
            .rotation(from: 0, to: .pi * 2),
            duration: 2,
            repeatCount: .infinity
        )
        mixedRotationLabel
            .animate(
                .rotationX(from: -.pi / 4, to: .pi / 4),
                duration: 2,
                repeatCount: .infinity,
                timingFunction: .linear,
                autoreverses: true
            )
            .animate(
                .rotationY(from: -.pi / 4, to: .pi / 4),
                duration: 3,
                repeatCount: .infinity,
                timingFunction: .linear,
                autoreverses: true
            )
            .animate(
                .rotation(from: -.pi / 4, to: .pi / 4),
                duration: 4,
                repeatCount: .infinity,
                timingFunction: .linear,
                autoreverses: true
            )
    }

    override func willDisappear(_ animated: Bool) {
        removeAllLayersAnimations()
    }
}

#Preview {
    CALayerAnimationsExamplesView().embeddedInController
}
