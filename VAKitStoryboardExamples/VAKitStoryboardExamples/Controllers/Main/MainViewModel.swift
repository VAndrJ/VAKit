//
//  MainViewModel.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 21.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import Foundation

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
