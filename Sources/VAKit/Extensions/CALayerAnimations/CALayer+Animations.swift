//
//  CALayer+Animations.swift
//  VAKit
//
//  Created by VAndrJ on 6/4/25.
//

import UIKit

extension CALayer {
    public struct VASpring: Sendable {
        public let initialVelocity: CGFloat
        public let damping: CGFloat
        public let mass: CGFloat
        public let swiftness: CGFloat

        public init(
            initialVelocity: CGFloat = 0,
            damping: CGFloat = 100,
            mass: CGFloat = 2,
            swiftness: CGFloat = 100
        ) {
            self.initialVelocity = initialVelocity
            self.damping = damping
            self.mass = mass
            self.swiftness = swiftness
        }
    }

    public struct VALayerAnimation: @unchecked Sendable {
        public let from: Any?
        public let to: Any?
        public let fromOriginalValue: Any?
        public let toOriginalValue: Any?
        public let keyPath: String
        public let isToEqualsFrom: Bool

        public init(
            from: Any?,
            to: Any?,
            fromOriginalValue: Any?,
            toOriginalValue: Any?,
            keyPath: String,
            isToEqualsFrom: Bool
        ) {
            self.from = from
            self.to = to
            self.fromOriginalValue = fromOriginalValue
            self.toOriginalValue = toOriginalValue
            self.keyPath = keyPath
            self.isToEqualsFrom = isToEqualsFrom
        }

        func getProgressMultiplier(current: Any?) -> Double {
            if let fromOriginalValue = fromOriginalValue as? (any VALayerAnimationValueConvertible) {
                return fromOriginalValue.getProgressMultiplier(
                    to: toOriginalValue,
                    current: current
                )
            } else {
                return 0
            }
        }
    }

    public struct VALayerKeyframeAnimation: @unchecked Sendable {
        public let values: [Any]
        public let keyPath: String

        public init(values: [Any], keyPath: String) {
            self.values = values
            self.keyPath = keyPath
        }
    }

    public var isAnimationsPaused: Bool { speed.isZero }
    public var hasAnimations: Bool { animationKeys().map { !$0.isEmpty } ?? false }

    @discardableResult
    public func add(
        animation: VALayerAnimation,
        duration: Double,
        delay: Double = 0.0,
        timeOffset: Double = 0.0,
        repeatCount: Float = 0.0,
        timingFunction: CAMediaTimingFunctionName = .easeInEaseOut,
        mediaTimingFunction: CAMediaTimingFunction? = nil,
        removeOnCompletion: Bool = true,
        autoreverses: Bool = false,
        additive: Bool = false,
        continueFromCurrent: Bool = false,
        force: Bool = false,
        spring: VASpring? = nil,
        completion: ((Bool) -> Void)? = nil
    ) -> Self {
        if animation.isToEqualsFrom && !force {
            completion?(true)

            return self
        }

        let basicAnimation = getAnimation(
            animation,
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
        add(basicAnimation, forKey: additive ? nil : animation.keyPath)

        return self
    }

    public func getAnimation(
        _ animation: VALayerAnimation,
        duration: Double,
        delay: Double = 0.0,
        timeOffset: Double = 0.0,
        repeatCount: Float = 0.0,
        timingFunction: CAMediaTimingFunctionName = .easeInEaseOut,
        mediaTimingFunction: CAMediaTimingFunction? = nil,
        removeOnCompletion: Bool = true,
        autoreverses: Bool = false,
        additive: Bool = false,
        continueFromCurrent: Bool = false,
        force: Bool = false,
        spring: VASpring? = nil,
        completion: ((Bool) -> Void)? = nil
    ) -> CABasicAnimation {
        var duration = duration
        var from = animation.from
        if delay.isZero, continueFromCurrent, let value = presentation()?.value(forKeyPath: animation.keyPath) {
            let progress = animation.getProgressMultiplier(current: value)
            duration *= progress
            from = value
        }

        return getAnimation(
            from: from,
            to: animation.to,
            keyPath: animation.keyPath,
            duration: duration,
            delay: delay,
            timeOffset: timeOffset,
            repeatCount: repeatCount,
            timingFunction: timingFunction,
            mediaTimingFunction: mediaTimingFunction,
            removeOnCompletion: removeOnCompletion,
            autoreverses: autoreverses,
            additive: additive,
            spring: spring,
            completion: completion
        )
    }

    @discardableResult
    public func add(
        animation: VALayerKeyframeAnimation,
        duration: Double,
        delay: Double = 0.0,
        timeOffset: Double = 0.0,
        repeatCount: Float = 0.0,
        timingFunction: CAMediaTimingFunctionName = .easeInEaseOut,
        mediaTimingFunction: CAMediaTimingFunction? = nil,
        removeOnCompletion: Bool = true,
        autoreverses: Bool = false,
        additive: Bool = false,
        completion: ((Bool) -> Void)? = nil
    ) -> Self {
        let kfAnimation = getAnimation(
            animation,
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
        add(kfAnimation, forKey: additive ? nil : animation.keyPath)

        return self
    }

    public func getAnimation(
        _ animation: VALayerKeyframeAnimation,
        duration: Double,
        delay: Double = 0.0,
        timeOffset: Double = 0.0,
        repeatCount: Float = 0.0,
        timingFunction: CAMediaTimingFunctionName = .easeInEaseOut,
        mediaTimingFunction: CAMediaTimingFunction? = nil,
        removeOnCompletion: Bool = true,
        autoreverses: Bool = false,
        additive: Bool = false,
        completion: ((Bool) -> Void)? = nil
    ) -> CAKeyframeAnimation {
        getAnimation(
            keyFrames: animation.values,
            duration: duration,
            delay: delay,
            timeOffset: timeOffset,
            repeatCount: repeatCount,
            keyPath: animation.keyPath,
            timingFunction: timingFunction,
            mediaTimingFunction: mediaTimingFunction,
            removeOnCompletion: removeOnCompletion,
            autoreverses: autoreverses,
            additive: additive,
            completion: completion
        )
    }

    private func getAnimation(
        keyFrames: [Any],
        duration: Double,
        delay: Double,
        timeOffset: Double,
        repeatCount: Float,
        keyPath: String,
        timingFunction: CAMediaTimingFunctionName,
        mediaTimingFunction: CAMediaTimingFunction?,
        removeOnCompletion: Bool,
        autoreverses: Bool,
        additive: Bool,
        completion: ((Bool) -> Void)?
    ) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.values = keyFrames
        var keyTimes: [NSNumber] = []
        for i in keyFrames.indices {
            if i == 0 {
                keyTimes.append(0.0)
            } else if i == keyFrames.count - 1 {
                keyTimes.append(1.0)
            } else {
                keyTimes.append(NSNumber(value: (Double(i) / Double(keyFrames.count - 1))))
            }
        }
        animation.keyTimes = keyTimes
        animation.duration = duration
        if !delay.isZero {
            animation.beginTime = convertTime(CACurrentMediaTime(), from: nil) + delay
            animation.fillMode = .both
        }
        animation.timeOffset = timeOffset
        animation.repeatCount = repeatCount
        if let mediaTimingFunction = mediaTimingFunction {
            animation.timingFunction = mediaTimingFunction
        } else {
            animation.timingFunction = CAMediaTimingFunction(name: timingFunction)
        }
        animation.isRemovedOnCompletion = removeOnCompletion
        animation.autoreverses = autoreverses
        animation.isAdditive = additive
        if let completion {
            animation.delegate = _AnimationDelegate(
                animation: animation,
                completion: completion
            )
        }

        return animation
    }

    private func animate(
        from: Any?,
        to: Any,
        keyPath: String,
        duration: Double,
        delay: Double,
        timeOffset: Double,
        repeatCount: Float,
        timingFunction: CAMediaTimingFunctionName,
        mediaTimingFunction: CAMediaTimingFunction?,
        removeOnCompletion: Bool,
        autoreverses: Bool,
        additive: Bool,
        spring: VASpring?,
        completion: ((Bool) -> Void)?
    ) {
        let animation = getAnimation(
            from: from,
            to: to,
            keyPath: keyPath,
            duration: duration,
            delay: delay,
            timeOffset: timeOffset,
            repeatCount: repeatCount,
            timingFunction: timingFunction,
            mediaTimingFunction: mediaTimingFunction,
            removeOnCompletion: removeOnCompletion,
            autoreverses: autoreverses,
            additive: additive,
            spring: spring,
            completion: completion
        )
        add(animation, forKey: additive ? nil : keyPath)
    }

    private func getAnimation(
        from: Any?,
        to: Any?,
        keyPath: String,
        duration: Double,
        delay: Double,
        timeOffset: Double,
        repeatCount: Float,
        timingFunction: CAMediaTimingFunctionName,
        mediaTimingFunction: CAMediaTimingFunction?,
        removeOnCompletion: Bool,
        autoreverses: Bool,
        additive: Bool,
        spring: VASpring?,
        completion: ((Bool) -> Void)?
    ) -> CABasicAnimation {
        let animation: CABasicAnimation
        if let spring {
            let springAnimation = CASpringAnimation(keyPath: keyPath)
            springAnimation.mass = spring.mass
            springAnimation.stiffness = spring.swiftness
            springAnimation.damping = spring.damping
            springAnimation.initialVelocity = spring.initialVelocity
            animation = springAnimation
        } else {
            animation = CABasicAnimation(keyPath: keyPath)
        }
        animation.fromValue = from
        animation.toValue = to
        if let springAnimation = animation as? CASpringAnimation {
            animation.duration = springAnimation.settlingDuration
        } else {
            animation.duration = duration
        }
        if !delay.isZero {
            animation.beginTime = convertTime(CACurrentMediaTime(), from: nil) + delay
            animation.fillMode = .both
        }
        if let mediaTimingFunction {
            animation.timingFunction = mediaTimingFunction
        } else {
            animation.timingFunction = CAMediaTimingFunction(name: timingFunction)
        }
        animation.timeOffset = timeOffset
        animation.repeatCount = repeatCount
        animation.isRemovedOnCompletion = removeOnCompletion
        animation.autoreverses = autoreverses
        animation.fillMode = .forwards
        animation.isAdditive = additive
        if let completion {
            animation.delegate = _AnimationDelegate(
                animation: animation,
                completion: completion
            )
        }

        return animation
    }

    @discardableResult
    public func animate(
        chain animations: [CAAnimation],
        key: String = UUID().uuidString,
        completion: ((Bool) -> Void)? = nil
    ) -> Self {
        let animationGroup = CAAnimationGroup()
        var duration = 0.0
        for animation in animations {
            animation.beginTime = convertTime(animation.beginTime, from: nil) + duration
            duration += animation.duration
        }
        animationGroup.animations = animations
        animationGroup.duration = duration
        if let completion {
            animationGroup.delegate = _AnimationDelegate(
                animation: animationGroup,
                completion: completion
            )
        }
        add(animationGroup, forKey: key)

        return self
    }

    @discardableResult
    public func animate(
        group animations: [CAAnimation],
        duration: TimeInterval,
        key: String = UUID().uuidString,
        removeOnCompletion: Bool = false,
        completion: ((Bool) -> Void)? = nil
    ) -> Self {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = animations
        animationGroup.duration = duration
        animationGroup.isRemovedOnCompletion = removeOnCompletion
        if let completion {
            animationGroup.delegate = _AnimationDelegate(
                animation: animationGroup,
                completion: completion
            )
        }
        add(animationGroup, forKey: key)

        return self
    }

    public func pauseAnimations() {
        if !isAnimationsPaused {
            let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
            speed = 0.0
            timeOffset = pausedTime
        }
    }

    public func resumeAnimations() {
        if isAnimationsPaused {
            let pausedTime = timeOffset
            speed = 1.0
            timeOffset = 0.0
            beginTime = 0.0
            let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            beginTime = timeSincePause
        }
    }
}

@objc private class _AnimationDelegate: NSObject, CAAnimationDelegate {
    private(set) var completion: ((Bool) -> Void)?
    private(set) var keyPath: String?

    init(animation: CAAnimation, completion: ((Bool) -> Void)?) {
        if let animation = animation as? CABasicAnimation {
            self.keyPath = animation.keyPath
        }
        self.completion = completion

        super.init()
    }

    @objc func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animation = anim as? CABasicAnimation {
            if animation.keyPath != keyPath {
                return
            }
        }

        if let completion {
            completion(flag)
            self.completion = nil
        }
    }
}
