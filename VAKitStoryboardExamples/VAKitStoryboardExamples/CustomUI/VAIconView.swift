//
//  VAIconView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 27.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

/*
 Not important for example
 */
class VAIconView: UIView {
    let foregroundView = VAGradientView().withShadow()
    let iconLabel = UILabel().withShadow().configured {
        $0.text = "VA"
        $0.textColor = .white
    }
    
    init(size: CGFloat) {
        super.init(frame: .init(x: 0, y: 0, width: size, height: size))
        addElements(size: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements(size: CGFloat) {
        self.size(size)
        addAutolayoutSubviews(foregroundView, iconLabel)
        foregroundView
            .toSuperEdges(insets: .init(all: size / 16))
        iconLabel
            .toSuperCenter()
    }
}
