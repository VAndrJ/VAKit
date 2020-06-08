//
//  TableSourceDelegate.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 08.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

/**
 Угу, нарушение ваших SRP, но удобный в использовании костыль для простейших случаев.
 */
class TableSourceDelegate: NSObject {
    private(set) var tableData: [TableCellConfigurable & VAIdentifiable] = []
    private weak var tableView: UITableView?
    
    init(tableView: UITableView, tableData: [TableCellConfigurable & VAIdentifiable]? = nil) {
        self.tableView = tableView
        if let tableData = tableData {
            self.tableData = tableData
        }
    }
    
    func update(data: [TableCellConfigurable & VAIdentifiable]) {
        self.tableData = data
        tableView?.reloadData()
    }
}
