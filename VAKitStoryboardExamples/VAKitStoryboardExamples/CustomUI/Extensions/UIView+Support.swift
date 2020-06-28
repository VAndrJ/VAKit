//
//  UIView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 28.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

extension UIView {
    
    func withShadow() -> Self {
        layer.shadowRadius = 2
        layer.shadowOffset = .init(width: 0, height: 1)
        layer.shadowColor = UIColor.systemPurple.cgColor
        layer.shadowOpacity = 0.4
        return self
    }
}
