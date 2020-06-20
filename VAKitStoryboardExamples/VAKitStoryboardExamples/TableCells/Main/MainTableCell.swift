//
//  MainTableCell.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 20.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

class MainTableCell: UITableViewCell {
    let titleLabel = UILabel().configured {
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    let secondaryTitleLabel = UILabel().configured {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 16, weight: .light)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        contentView.addAutolayoutSubviews(titleLabel, secondaryTitleLabel)
        titleLabel
            .toSuperAxis(.horizontal, symmetric: 16)
            .toSuper(.top, constant: 16)
        secondaryTitleLabel
            .toSuperAxis(.horizontal, symmetric: 16)
            .toSuper(.bottom, constant: -16)
            .anchor(.top, opposingTo: titleLabel, constant: 8)
    }
}
