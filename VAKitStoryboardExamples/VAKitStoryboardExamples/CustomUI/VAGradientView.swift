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
    let gradientView = VAGradientView()
    var maskPath: UIBezierPath {
        let path = UIBezierPath()
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.compact, .compact), (.regular, .compact):
            path.move(to: .init(x: bounds.minX, y: bounds.minY))
            path.addLine(to: .init(x: bounds.midX, y: bounds.minY))
            path.addQuadCurve(to: .init(x: bounds.maxX, y: bounds.midY), controlPoint: .init(x: bounds.maxX, y: bounds.maxY / 5))
            path.addQuadCurve(to: .init(x: bounds.midX, y: bounds.maxY), controlPoint: .init(x: bounds.maxX, y: bounds.maxY * 4 / 5))
            path.addLine(to: .init(x: bounds.minX, y: bounds.maxY))
            path.close()
        default:
            path.move(to: .init(x: bounds.minX, y: bounds.minY))
            path.addLine(to: .init(x: bounds.minX, y: bounds.midY))
            path.addQuadCurve(to: .init(x: bounds.midX, y: bounds.maxY), controlPoint: .init(x: bounds.maxX / 5, y: bounds.maxY))
            path.addQuadCurve(to: .init(x: bounds.maxX, y: bounds.midY), controlPoint: .init(x: bounds.maxX * 4 / 5, y: bounds.maxY))
            path.addLine(to: .init(x: bounds.maxX, y: bounds.minY))
            path.close()
        }
        return path
    }
    
    init() {
        super.init(frame: .init(x: 0, y: 0, width: 100, height: 100))
        addElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        gradientView.layer.mask = maskLayer
    }
    
    func addElement() {
        addAutolayoutSubview(gradientView)
        gradientView
            .toSuperEdges()
    }
}
