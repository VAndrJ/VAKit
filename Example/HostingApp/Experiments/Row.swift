//
//  Row.swift
//  HostingApp
//
//  Created by VAndrJ on 6/4/25.
//

import UIKit
import VAKit

public enum ContainerConstraintsJustifyContent {
    case fillEqually
    case centerEvently
}

public enum ContainerConstraintsAlignItems {
    case start
    case fill
    case end
    case center
}

@MainActor
public struct Row: Constraints {
    public let constraints: [NSLayoutConstraint]

    public init(
        views: [PlatformView],
        main: ContainerConstraintsJustifyContent,
        cross: ContainerConstraintsAlignItems,
        spacing: CGFloat,
        isSafe: Bool
    ) {
        var result: [NSLayoutConstraint] = []

        switch cross {
        case .start:
            for view in views {
                result.append(NSLayoutConstraint(
                    item: view,
                    attribute: .top,
                    relatedBy: .equal,
                    toItem: isSafe ? view.superview!.safeAreaLayoutGuide : view.superview!,
                    attribute: .top,
                    multiplier: 1,
                    constant: 0 // TODO: - insets?
                ))
            }
        case .fill:
            for view in views {
                result.append(NSLayoutConstraint(
                    item: view,
                    attribute: .top,
                    relatedBy: .equal,
                    toItem: isSafe ? view.superview!.safeAreaLayoutGuide : view.superview!,
                    attribute: .top,
                    multiplier: 1,
                    constant: 0
                ))
                result.append(NSLayoutConstraint(
                    item: view,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: isSafe ? view.superview!.safeAreaLayoutGuide : view.superview!,
                    attribute: .bottom,
                    multiplier: 1,
                    constant: 0
                ))
            }
        case .end:
            for view in views {
                result.append(NSLayoutConstraint(
                    item: view,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: isSafe ? view.superview!.safeAreaLayoutGuide : view.superview!,
                    attribute: .bottom,
                    multiplier: 1,
                    constant: 0
                ))
            }
        case .center:
            for view in views {
                result.append(NSLayoutConstraint(
                    item: view,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: isSafe ? view.superview!.safeAreaLayoutGuide : view.superview!,
                    attribute: .centerY,
                    multiplier: 1,
                    constant: 0
                ))
            }
        }

        switch main {
        case .fillEqually:
            if let firstView = views.first {
                result.append(NSLayoutConstraint(
                    item: firstView,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: isSafe ? firstView.superview!.safeAreaLayoutGuide : firstView.superview!,
                    attribute: .leading,
                    multiplier: 1,
                    constant: 0
                ))
            }
            for (prev, next) in zip(views, views.dropFirst()) {
                result.append(NSLayoutConstraint(
                    item: next,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: prev,
                    attribute: .trailing,
                    multiplier: 1,
                    constant: spacing
                ))
                result.append(NSLayoutConstraint(
                    item: next,
                    attribute: .width,
                    relatedBy: .equal,
                    toItem: prev,
                    attribute: .width,
                    multiplier: 1,
                    constant: 0
                ))
            }
            if let lastView = views.last {
                result.append(NSLayoutConstraint(
                    item: lastView,
                    attribute: .trailing,
                    relatedBy: .equal,
                    toItem: isSafe ? lastView.superview!.safeAreaLayoutGuide : lastView.superview,
                    attribute: .trailing,
                    multiplier: 1,
                    constant: 0
                ))
            }
        case .centerEvently:
            let count = CGFloat(views.count)
            for i in views.indices {
                let multiplier = 2 * (CGFloat(i) + 0.5) / count
                result.append(NSLayoutConstraint(
                    item: views[i],
                    attribute: .centerX,
                    relatedBy: .equal,
                    toItem: views[i].superview!,
                    attribute: .centerX,
                    multiplier: multiplier,
                    constant: 0
                ))
            }
        }

        self.constraints = result
    }

    public init(
        spacing: CGFloat = 0,
        main: ContainerConstraintsJustifyContent = .fillEqually,
        cross: ContainerConstraintsAlignItems = .fill,
        isSafe: Bool = false,
        @ArrayBuilder<PlatformView> builder: () -> [PlatformView]
    ) {
        self.init(
            views: builder(),
            main: main,
            cross: cross,
            spacing: spacing,
            isSafe: isSafe
        )
    }
}
