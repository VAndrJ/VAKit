//
//  MainContract.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 21.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func showDifferentSizeViewAnyPhonePortraitLandscapeExample()
}

protocol MainViewProtocol {
    var tableView: UITableView { get }
}

protocol MainViewModelProtocol {
    var tableData: [MainTableCellEntity] { get }
    
    func onSelectRow(at indexPath: IndexPath)
}

struct MainViewControllerConfigurator {
    let controller: UIViewController
    
    init(coordinator: MainCoordinatorDelegate) {
        let viewModel = MainViewModel(coordinator: coordinator)
        self.controller = MainViewController(contentsView: MainView(), viewModel: viewModel)
    }
}
