//
//  VAGradientView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 27.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

/*
 Not important for example
 */
class VAGradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    convenience init() {
        self.init(frame: .init(x: 0, y: 0, width: 10, height: 10))
        configure()
    }
    
    private func configure() {
        let layer = gradientLayer
        layer.startPoint = .init(x: 0, y: 0)
        layer.endPoint = .init(x: 1, y: 1)
        layer.locations = [0.05, 0.95]
        layer.colors = [UIColor.systemPurple.cgColor, UIColor.systemTeal.cgColor]
    }
}

class VARoundedEdgeView: UIView {
}
