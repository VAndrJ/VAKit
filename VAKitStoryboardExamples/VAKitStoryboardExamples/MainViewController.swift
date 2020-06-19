//
//  RootViewController.swift
//  VAKitStoryboardExamples
//
//  Created by VAndrJ on 02.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

protocol MainCoordinatorDelegate {
    
}

struct MainViewControllerConfigurator {
    let controller: UIViewController
    
    init(coordinator: RootCoordinator) {
        let viewModel = RootViewModel(coordinator: coordinator)
        self.controller = RootViewController(contentsView: RootView(), viewModel: viewModel)
    }
}

class RootView: UIView {
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

class RootViewController: UIViewController {
    let contentsView: RootView
    let viewModel: RootViewModel
    
    var tableSource: TableSourceDelegate!
    
    init(contentsView: RootView, viewModel: RootViewModel) {
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
        let viewModel = self.viewModel
        tableSource = TableSourceDelegate(
            tableView: contentsView.tableView,
            tableData: viewModel.tableData,
            onSelectRow: viewModel.onSelectRow(at:)
        )
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
}

class RootViewModel {
    let coordinator: RootCoordinator
    let tableData: [MainListObject] = [
        MainListObject(title: "iPhone of any size. Different portrait/landscape element size", destination: .iPhoneAnyPortraitLandscape),
    ]
    
    init(coordinator: RootCoordinator) {
        self.coordinator = coordinator
    }
    
    func onSelectRow(at indexPath: IndexPath) {
        let destination = tableData[indexPath.row].destination
        coordinator.onOpen(destination: destination)
    }
}

enum MainDestination {
    case iPhoneAnyPortraitLandscape
}

struct MainListObject {
    let title: String
    let destination: MainDestination
}

extension MainListObject: VAIdentifiable {}

extension MainListObject: TableCellConfigurable {
    var cellClass: UITableViewCell.Type {
        MainTableViewCell.self
    }
    
    func configure(cell: UITableViewCell) {
        let cell = cell as! MainTableViewCell
        cell.titleLabel.text = title
        cell.accessoryType = .disclosureIndicator
    }
}

class MainTableViewCell: UITableViewCell {
    let titleLabel = UILabel().configured {
        $0.numberOfLines = 2
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        contentView.addAutolayoutSubview(titleLabel)
        contentView
            .size(height: 52, priority: 999)
        titleLabel
            .toSuper(.centerY)
            .toSuperAxis(.horizontal, symmetric: 16)
    }
}
