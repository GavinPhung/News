//
//  SegmentedControlCellViewModel.swift
//  News
//
//  Created by Gavin Phung on 08/04/2021.
//

import Foundation

class SegmentedControlCellViewModel: CellViewModel {
    var cellIdentifier: String = "SegmentedControlCell"
    
    var title: String
    var isSelected = false
    
    init(title: String) {
        self.title = title
    }
}
