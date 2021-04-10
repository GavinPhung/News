//
//  NewsArticleCell.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import UIKit

protocol CellProtocol: UICollectionViewCell  {
    func configureWith(viewModel: CellViewModel)
}

typealias CollectionViewCell = CellProtocol & UICollectionViewCell
typealias TableViewCell = CellProtocol & UITableViewCell

protocol CellViewModel {
    var cellIdentifier: String { get }
}

class NewsArticleCell: CollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configureWith(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? NewsArticleCellViewModel else { return }
        
        viewModel.delegate = self
        
        titleLabel.text = viewModel.title
        viewModel.updateImage()
        
        imageView.layer.cornerRadius = 5
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.backgroundColor = Colors.background.color
    }
}

extension NewsArticleCell: ImageDelegate {
    func update(image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
