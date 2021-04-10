//
//  SegmentedControlCell.swift
//  News
//
//  Created by Gavin Phung on 08/04/2021.
//

import UIKit

class SegmentedControlCell: CollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configureWith(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? SegmentedControlCellViewModel else {
            return
        }
        
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.isSelected ? .red : .black
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        titleLabel.backgroundColor = Colors.background.color
    }
}
