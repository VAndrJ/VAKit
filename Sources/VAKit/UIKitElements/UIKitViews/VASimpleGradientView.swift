//
//  VASimpleGradientView.swift
//  VAKit
//
//  Created by Volodymyr Andriienko on 12.07.2025.
//

#if canImport(UIKit)
import UIKit

open class VASimpleGradientView: UIView {
    open override class var layerClass: AnyClass { CAGradientLayer.self }

    open override var layer: CAGradientLayer { super.layer as! CAGradientLayer }

    public init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
