//
//  VAConstraintable.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 16.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

protocol VAConstraintable {
    
    /*
     Compact width, regular height.
     Devices like iPhone in portrait orientation
     or iPad split screen in portrait.
     */
    var cWrHConstraints: [NSLayoutConstraint] { get set }
    
    /*
     Compact width, compact height.
     Devices like small iPhone (4 / 5 / 6 / etc.) in landscape mode.
     */
    var cWcHConstraints: [NSLayoutConstraint] { get set }
}
