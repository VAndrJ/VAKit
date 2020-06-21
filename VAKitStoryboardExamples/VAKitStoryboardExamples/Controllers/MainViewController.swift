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
    let contentsView: MainViewProtocol & UIView
    let viewModel: MainViewModelProtocol
    
    var tableSourceDelegate: TableSourceDelegate!
    
    init(contentsView: MainViewProtocol & UIView, viewModel: MainViewModelProtocol) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = contentsView.tableView.indexPathForSelectedRow {
            if let coordinator = transitionCoordinator {
                coordinator.animate(alongsideTransition: { context in
                    self.contentsView.tableView.deselectRow(at: selectedIndexPath, animated: true)
                }) { context in
                    if context.isCancelled {
                        self.contentsView.tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
                    }
                }
            } else {
                self.contentsView.tableView.deselectRow(at: selectedIndexPath, animated: animated)
            }
        }
    }
    
    private func bind() {
        tableSourceDelegate = TableSourceDelegate(
            tableView: contentsView.tableView,
            tableData: viewModel.tableData,
            onSelectRow: viewModel.onSelectRow(at:)
        )
    }
}

class MainViewModel: MainViewModelProtocol {
    unowned let coordinator: MainCoordinatorDelegate
    
    let tableData: [MainTableCellEntity] = [
        MainTableCellEntity(title: "iPhone of any size with different element size in portrait and landscape", secondaryTitle: "One centered view with different sizes. VAView used."),
    ]
    
    init(coordinator: MainCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func onSelectRow(at indexPath: IndexPath) {
        let cellData = tableData[indexPath.row]
    }
}
