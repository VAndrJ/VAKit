//
//  MainTableCellEntity.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 20.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

enum Destination {
    case iPhoneAnySizeDifferentPortraitLandscapeSize
}

struct MainTableCellEntity: VAIdentifiable {
    let title: String
    let secondaryTitle: String
    let destination: Destination
}

extension MainTableCellEntity: TableCellConfigurable {
    var cellClass: UITableViewCell.Type {
        return MainTableCell.self
    }
    
    func configure(cell: UITableViewCell) {
        let cell = cell as! MainTableCell
        cell.titleLabel.text = title
        cell.secondaryTitleLabel.text = secondaryTitle
        cell.accessoryType = .disclosureIndicator
    }
}
