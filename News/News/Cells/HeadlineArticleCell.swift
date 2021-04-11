//
//  HeadlineArticleCell.swift
//  News
//
//  Created by Gavin Phung on 07/04/2021.
//

import UIKit

class HeadlineArticleCell: CollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var titleStackView: UIStackView!
    
    func configureWith(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? HeadlineArticleCellViewModel else { return }
        
        viewModel.delegate = self
        
        titleLabel.text = viewModel.title
        imageView.layer.cornerRadius = 5
        
        viewModel.updateImage()
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .label
        dateLabel.text = viewModel.date
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        authorLabel.text = viewModel.author
        authorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        authorLabel.textColor = .label
        titleStackView.backgroundColor = .white
        infoStackView.backgroundColor = .white
        infoStackView.layer.cornerRadius = 5
    }
}

extension HeadlineArticleCell: ImageDelegate {
    func update(image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
