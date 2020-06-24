//
//  MainView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 21.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

class MainView: UIView, MainViewProtocol {
    let tableView = UITableView()
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        addElements()
        configure()
    }
    
    private func configure() {
        backgroundColor = .white
    }
    
    /*
     Just constraints for all size classes.
     Maybe add something more in the future.
     */
    func addElements() {
        addAutolayoutSubview(tableView)
        tableView
            .toSuperEdges(isSafe: true)
    }
}
