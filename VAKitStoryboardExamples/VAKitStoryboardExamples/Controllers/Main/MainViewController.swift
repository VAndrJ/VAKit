//
//  MainViewController.swift
//  VAKitStoryboardExamples
//
//  Created by VAndrJ on 02.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

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
