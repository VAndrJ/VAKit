//
//  Coordinator.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 19.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var presentationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
