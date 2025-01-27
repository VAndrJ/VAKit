//
//  VASimpleButton.swift
//  VAKit
//
//  Created by VAndrJ on 1/27/25.
//

#if canImport(UIKit)
import UIKit

open class VASimpleButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
