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

class MainView: UIView {
    let tableView = UITableView()
    let someForFunButton = UIButton(type: .system).configured {
        $0.setTitle("Some Button title", for: .normal)
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        addElements()
        configure()
    }
    
    private func configure() {
        backgroundColor = .white
    }
    
    private func addElements() {
        addAutolayoutSubviews(tableView, someForFunButton)
        tableView
            .toSuper(anchors: .top, .leading, .trailing, isSafe: true)
            .anchor(.bottom, opposingTo: someForFunButton)
        someForFunButton
            .toSuper(anchors: .leading, .bottom, .trailing, isSafe: true)
            .size(height: 52)
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
