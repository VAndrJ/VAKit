//
//  TableSourceDelegate.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 08.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

/*
 Угу, нарушение ваших SRP, но удобный в использовании костыль для простейших случаев.
 */
class TableSourceDelegate: NSObject {
    private(set) var tableData: [TableCellConfigurable & VAIdentifiable] = []
    private weak var tableView: UITableView?
    private let onSelectRow: ((IndexPath) -> Void)?
    
    init(tableView: UITableView, tableData: [TableCellConfigurable & VAIdentifiable]? = nil, onSelectRow: ((IndexPath) -> Void)?) {
        self.tableView = tableView
        self.onSelectRow = onSelectRow
        if let tableData = tableData {
            self.tableData = tableData
        }
        super.init()
        tableView.estimatedRowHeight = 52
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func update(data: [TableCellConfigurable & VAIdentifiable]) {
        self.tableData = data
        tableView?.reloadData()
    }
}

extension TableSourceDelegate: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueConfigured(withObject: tableData[indexPath.row])
    }
}

extension TableSourceDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectRow?(indexPath)
    }
}
