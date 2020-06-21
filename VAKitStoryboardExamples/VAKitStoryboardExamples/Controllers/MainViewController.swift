//
//  MainViewController.swift
//  VAKitStoryboardExamples
//
//  Created by VAndrJ on 02.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
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
    
    private func addElements() {
        addAutolayoutSubview(tableView)
        tableView
            .toSuperEdges(isSafe: true)
    }
}

class MainViewController: UIViewController {
    let contentsView: MainView
    let viewModel: MainViewModelProtocol
    
    init(contentsView: MainView, viewModel: MainViewModelProtocol) {
        self.contentsView = contentsView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentsView
    }
}

class MainViewModel: MainViewModelProtocol {
    unowned let coordinator: MainCoordinatorDelegate
    
    init(coordinator: MainCoordinatorDelegate) {
        self.coordinator = coordinator
    }
}
