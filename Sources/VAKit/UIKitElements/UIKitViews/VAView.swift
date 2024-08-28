//
//  VAView.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

#if canImport(UIKit)
import UIKit

open class VAView: VASimpleView {

    public override init(frame: CGRect) {
        super.init(frame: frame)

        addElements()
        configure()
        bind()
    }

    open func addElements() {}

    open func configure() {}

    open func bind() {}
}
#endif
