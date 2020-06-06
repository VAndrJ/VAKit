//
//  RootViewController.swift
//  VAKitStoryboardExamples
//
//  Created by VAndrJ on 02.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

struct RootViewControllerConfigurator {
    let controller: UIViewController
    
    init() {
        self.controller = RootViewController(contentView: RootView())
    }
}

class RootView: UIView {
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        configure()
    }
    
    private func configure() {
        backgroundColor = .white
    }
}

class RootViewController: UIViewController {
    let contentView: RootView
    
    init(contentView: RootView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
}
