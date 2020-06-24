//
//  RootCoordinator.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 06.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {
    let presentationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(presentationController: UINavigationController) {
        self.presentationController = presentationController
    }
    
    func start() {
        presentationController.setViewControllers(getRootControllers(), animated: false)
    }
    
    private func getRootControllers() -> [UIViewController] {
        return [MainViewControllerConfigurator(coordinator: self).controller]
    }
}

extension RootCoordinator: MainCoordinatorDelegate {
    
    func showDifferentSizeViewAnyPhonePortraitLandscapeExample() {
        presentationController.pushViewController(DifferentPortraitLandscapeAnyPhoneSizeConfigurator().controller, animated: true)
    }
}
