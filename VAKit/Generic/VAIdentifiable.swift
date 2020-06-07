//
//  VAIdentifiable.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 07.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import Foundation

protocol VAIdentifiable {
    static var identifier: String { get }
    var identifier: String { get }
}
