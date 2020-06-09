//
//  UITableView+Dequeue.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 08.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueConfigured(withObject object: TableCellConfigurable & VAIdentifiable) -> UITableViewCell {
        let tableCell: UITableViewCell
        if let cell = dequeueReusableCell(withIdentifier: object.identifier) {
            tableCell = cell
        } else {
            register(object.cellClass, forCellReuseIdentifier: object.identifier)
            tableCell = dequeueReusableCell(withIdentifier: object.identifier)!
        }
        object.configure(cell: tableCell)
        return tableCell
    }
}
