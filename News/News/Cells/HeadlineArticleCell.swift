//
//  HeadlineArticleCell.swift
//  News
//
//  Created by Gavin Phung on 07/04/2021.
//

import UIKit

class HeadlineArticleCell: Cell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    func configureWith(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? HeadlineArticleCellViewModel else { return }
        
        titleLabel.text = viewModel.title
        imageView.image = viewModel.image
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 5
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .label
        
        authorLabel.text = viewModel.author
        authorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        authorLabel.textColor = .label
    }
    

}
