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
    
}
