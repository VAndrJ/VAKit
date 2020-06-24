//
//  MainViewModel.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 21.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import Foundation

class MainViewModel: MainViewModelProtocol {
    enum Destination {
        case differentPortraitLandscapeAnyPhoneSize
    }
    
    unowned let coordinator: MainCoordinatorDelegate
    
    let _tableData: [(data: MainTableCellEntity, destination: Destination)] = [
        (
            MainTableCellEntity(
                title: "iPhone of any size with different element size in portrait and landscape",
                secondaryTitle: "One centered view with different sizes. VAView used."
            ),
            .differentPortraitLandscapeAnyPhoneSize
        ),
    ]
    var tableData: [MainTableCellEntity] {
        return _tableData.map({ $0.data })
    }
    
    init(coordinator: MainCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func onSelectRow(at indexPath: IndexPath) {
        let destination = _tableData[indexPath.row].destination
        switch destination {
        case .differentPortraitLandscapeAnyPhoneSize:
            coordinator.showDifferentSizeViewAnyPhonePortraitLandscapeExample()
        }
    }
}
