//
//  UIView+Animations.swift
//  VAKit
//
//  Created by VAndrJ on 6/4/25.
//

import UIKit

extension UIView {

    @discardableResult
    public func animate(
        _ animation: CALayer.VALayerAnimation,
        duration: Double,
        delay: Double = 0.0,
        timeOffset: Double = 0.0,
        repeatCount: Float = 0.0,
        timingFunction: CAMediaTimingFunctionName = .easeInEaseOut,
        mediaTimingFunction: CAMediaTimingFunction? = nil,
        removeOnCompletion: Bool = true,
        applyingResult: Bool = false,
        autoreverses: Bool = false,
        additive: Bool = false,
        continueFromCurrent: Bool = false,
        force: Bool = false,
        spring: CALayer.VASpring? = nil,
        completion: (@Sendable (Bool) -> Void)? = nil
    ) -> Self {
        layer.add(
            animation: animation,
            duration: duration,
            delay: delay,
            timeOffset: timeOffset,
            repeatCount: repeatCount,
            timingFunction: timingFunction,
            mediaTimingFunction: mediaTimingFunction,
            removeOnCompletion: removeOnCompletion,
            autoreverses: autoreverses,
            additive: additive,
            continueFromCurrent: continueFromCurrent,
            force: force,
            spring: spring,
            completion: completion
        )
        if applyingResult {
            layer.setValue(animation.to, forKeyPath: animation.keyPath)
        }

        return self
    }

    @discardableResult
    public func animate(
        _ animation: CALayer.VALayerKeyframeAnimation,
        duration: Double,
        delay: Double = 0.0,
        timeOffset: Double = 0.0,
        repeatCount: Float = 0.0,
        timingFunction: CAMediaTimingFunctionName = .easeInEaseOut,
        mediaTimingFunction: CAMediaTimingFunction? = nil,
        removeOnCompletion: Bool = true,
        autoreverses: Bool = false,
        additive: Bool = false,
        completion: (@Sendable (Bool) -> Void)? = nil
    ) -> Self {
        layer.add(
            animation: animation,
            duration: duration,
            delay: delay,
            timeOffset: timeOffset,
            repeatCount: repeatCount,
            timingFunction: timingFunction,
            mediaTimingFunction: mediaTimingFunction,
            removeOnCompletion: removeOnCompletion,
            autoreverses: autoreverses,
            additive: additive,
            completion: completion
        )

        return self
    }

    public func removeAllLayersAnimations() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        disableAllAnimations(layer: layer)
        CATransaction.commit()
    }

    private func disableAllAnimations(layer: CALayer) {
        layer.removeAllAnimations()
        layer.sublayers?.forEach { disableAllAnimations(layer: $0) }

    }

    public func getHasAnimations(_ block: @Sendable @escaping (Bool) -> Void) {
        block(layer.hasAnimations)
    }

    public func pauseAnimations() {
        layer.pauseAnimations()
    }

    public func resumeAnimations() {
        layer.resumeAnimations()
    }
}
