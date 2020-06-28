//
//  NSDirectionalEdgeInsets.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 27.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

extension NSDirectionalEdgeInsets {
    
    init(all constant: CGFloat) {
        self.init(top: constant, leading: constant, bottom: constant, trailing: constant)
    }
}
