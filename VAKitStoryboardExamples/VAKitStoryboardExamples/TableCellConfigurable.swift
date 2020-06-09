//
//  TableCellConfigurable.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 07.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

protocol CellConfigurable {
    var cellClass: AnyObject.Type { get }
    
    func configure(cell: AnyObject)
}

protocol TableCellConfigurable {
    var cellClass: UITableViewCell.Type { get }
    
    func configure(cell: UITableViewCell)
}
